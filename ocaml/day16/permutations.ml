open Io

(* Generate a list of program names *)
let init_programs size = List.init size (fun i -> Printf.sprintf "%c" (char_of_int (i + 97)))

(* Get the offset version of a circular list *)
let circular offset l =
  let rec aux l acc offset =
    match l, acc, offset with
    | [], [], _ -> []
    | [], _, o when o <= 0 -> List.rev acc
    | [], _, _ -> aux (List.rev acc) [] offset
    | hd::tl, _, o when o <= 0 -> l @ (List.rev acc)
    | hd::tl, _, _ -> aux tl (hd :: acc) (offset - 1)
  in aux l [] offset

(* Spin a list by moving n elements to the front *)
let spin n l =
  let size = List.length l in
  circular (size - n) l

(* Swap the i-th and j-th elements of a list *)
let exchange i j l =
  let old_i, old_j = List.nth l i, List.nth l j in
  List.mapi (fun idx e -> if idx = i then old_j else if idx = j then old_i else e) l

(* Change elements of a list with value p1 to p2, and vice versa *)
let partner p1 p2 l =
  List.map (fun p -> if p = p1 then p2 else if p = p2 then p1 else p) l

(* Get the move function from a move code string *)
let move code =
  let split s =
    let sp = String.split_on_char '/' s in
    (List.hd sp, List.nth sp 1)
  and l = (String.length code) - 1 in
  match code.[0] with
  | 's' -> spin (int_of_string (String.sub code 1 l))
  | 'x' ->
      let i, j = split (String.sub code 1 l) in
      exchange (int_of_string i) (int_of_string j)
  | 'p' ->
      let a, b = split (String.sub code 1 l) in
      partner a b
  | _ -> failwith "invalid move"

(* Execute one dance round, reading moves from a file *)
let dance_iter size moves programs =
  let rec parse_and_dance stream current_move programs =
    match Stream.peek stream, current_move with
    | None, [] -> print_endline "tut"; programs
    | None, _ -> move (string_of_chars (List.rev current_move)) programs
    | Some ',', _ ->
        Stream.junk stream;
        parse_and_dance stream [] (move (string_of_chars (List.rev current_move)) programs)
    | Some c, _ when (c >= 'a' && c <= 'z') || (c >= '0' && c <= '9') || c = '/' ->
        Stream.junk stream;
        parse_and_dance stream (c :: current_move) programs
    | Some c, _ ->
        Stream.junk stream;
        parse_and_dance stream current_move programs
  in
  let ic = open_in moves in
  let moves_stream = Stream.of_channel ic in
  let progs = parse_and_dance moves_stream [] programs in
  close_in ic;
  progs

let dance_1 size moves_file =
  dance_iter size moves_file (init_programs size)

(* Brute force isn't really an option here... so we dance until we find a dance
 * cyle (initiated at step n and finished at m, giving programs ps). Then we
 * only have to iterate (iters - n) mod (m - n) times, with initial programs ps
 * to find the target result :) *)
let dance_2 iters size moves_file =
  let init = init_programs size in
  let rec first_cycle iter programs seen =
    let new_programs = dance_iter size moves_file programs in
    if List.exists (fun (p,i) -> p = new_programs) seen then
      let first_seen_iter = List.assoc new_programs seen in
      new_programs, first_seen_iter, iter + 1 - first_seen_iter
    else first_cycle (iter + 1) new_programs ((new_programs, iter + 1) :: seen)
  in
  let cycle_programs, first, length = first_cycle 0 init [(init, 0)] in
  let rec dance_loop target iter programs =
    if iter = target then programs
    else dance_loop target (iter + 1) (dance_iter size moves_file programs)
  in dance_loop ((iters - first) mod length) 0 cycle_programs
