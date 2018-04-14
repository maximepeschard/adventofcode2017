open Printf

(* Get a list of the ASCII codes from a string *)
let to_ascii_codes s =
  let rec aux stream acc =
    match Stream.peek stream with
    | None -> List.rev acc
    | Some c -> Stream.junk stream; aux stream ((int_of_char c) :: acc)
  in aux (Stream.of_string s) []

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

(* Split a list by taking the first n elements and return them along the remainings ones *)
let take n xs =
  let rec take_aux n xs acc =
    if n <= 0 then List.rev acc, xs
    else
      match xs with
      | [] -> List.rev acc, []
      | hd::tl -> take_aux (n - 1) tl (hd :: acc)
  in take_aux n xs []

(* Perform a round of the Knot Hash algorithm *)
let rec hash_round xs size lengths skip pos =
  match lengths with
  | [] -> xs, skip, pos
  | hd::tl ->
      let first, rem = take hd xs in
      let new_xs = circular (hd + skip) ((List.rev first) @ rem) in
      hash_round new_xs size tl (skip + 1) ((pos + hd + skip) mod size)

(* Build a dense hash from a sparse hash *)
let dense_hash block_size sparse =
  let rec aux sparse acc =
    match sparse with
    | [] -> List.rev acc
    | _ ->
        let block, tl = take block_size sparse in
        aux tl ((List.fold_left (lxor) 0 block) :: acc)
  in aux sparse []

let hash_1 size lengths_str =
  let lengths = List.map int_of_string (Str.split (Str.regexp ",[ \t]*") lengths_str)
  and xs = List.init size (fun x -> x) in
  let l, skip, pos = hash_round xs size lengths 0 0 in
  let final = circular (size - pos) l in
  (List.nth final 0) * (List.nth final 1)

let hash_2 size block_size rounds suffix lengths_str =
  let lengths = (to_ascii_codes lengths_str) @ suffix
  and xs = List.init size (fun x -> x) in
  let rec loop n xs skip pos =
    if n = 0 then xs, skip, pos
    else
      let xs, skip, pos =  hash_round xs size lengths skip pos in
      loop (n - 1) xs skip pos
  in
  let xs, skip, pos = loop rounds xs 0 0 in
  let sparse = circular (size - pos) xs in
  let dense = dense_hash block_size sparse in
  String.concat "" (List.map (fun n -> sprintf "%02x" n) dense)
