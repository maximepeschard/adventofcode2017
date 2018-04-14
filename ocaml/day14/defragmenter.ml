(* Compute the Knot Hash of a string (we use code from day10) *)
let knot_hash s = Hash.hash_2 256 16 64 [17; 31; 73; 47; 23] s

(* Pad a list l with e until size s *)
let rec pad e s l =
  if s - (List.length l) <= 0 then l else pad e s (e :: l)

(* Convert a char to a 4 bits, represented as a list of 0s and 1s
 * Example: binary_of_hexchar '1' = [0; 0; 0; 1] *)
let binary_of_hexchar c =
  let rec bin_of_int n acc =
    match n, List.length acc with
    | _, 4 -> acc
    | 0, _ -> 0 :: acc
    | _, _ -> bin_of_int (n / 2) (n mod 2 :: acc)
  in bin_of_int (int_of_string ("0x" ^ (String.make 1 c))) []
  |> pad 0 4

(* Convert a string to length * 4 bits *)
let to_binary s =
  let stream = Stream.of_string s in
  let rec loop st acc =
    match Stream.peek st with
    | None -> List.rev acc
    | Some c ->
        Stream.junk st;
        let add_bin bins b = b :: bins in
        loop st (List.fold_left add_bin acc (binary_of_hexchar c))
  in loop stream []

(* Iterator on the rows of a disk *)
let fold_disk key func init rows =
  let rec loop row acc =
    if row = rows then acc
    else
      to_binary (knot_hash (key ^ "-" ^ string_of_int row))
      |> List.fold_left func acc
      |> loop (row + 1)
  in loop 0 init

let used_squares rows key = fold_disk key (+) 0 rows

(* Replace a value by another in a list *)
let replace oldv newv l =
  List.fold_left (fun acc n -> if n = oldv then newv :: acc else n :: acc) [] l
  |> List.rev

(* Color blob algorithm step *)
let blob_coloring (left, regions, colored_row, nb_regions) up cur =
  match left, up, cur with
  | 0, 0, 1 ->
      let nb = nb_regions + 1 in
      (nb, nb :: regions, nb :: colored_row, nb)
  | 0, u, 1 when u > 0 -> (up, regions, up :: colored_row, nb_regions)
  | l, 0, 1 when l > 0 -> (left, regions, left :: colored_row, nb_regions)
  | l, u, 1 when l > 0 && u > 0 ->
      (up, (replace left up regions), up :: (replace left up colored_row), nb_regions)
  | _, _, _ -> (cur, regions, cur :: colored_row, nb_regions)

(* Count distinct values in a list *)
let count_unique l =
  List.fold_left (fun acc x -> if List.mem x acc then acc else x :: acc) [] l
  |> List.length

let regions rows key =
  let rec regions_loop row prev_row reg nb =
    if row = rows then reg
    else
      let row_hash = to_binary (knot_hash (key ^ "-" ^ string_of_int row)) in
      let _, reg, r, nb = List.fold_left2 blob_coloring (0, reg, [], nb) prev_row row_hash in
      regions_loop (row + 1) (List.rev r) reg nb
  in
  regions_loop 0 (List.init rows (fun n -> 0)) [] 0
  |> count_unique
