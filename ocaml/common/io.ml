(* Read a file and return the list of lines *)
let read_lines filename =
  let ic = open_in filename in
  let rec file_to_lines acc ic =
    match input_line ic with
    | line -> file_to_lines (line :: acc) ic
    | exception End_of_file -> close_in ic; List.rev acc
  in file_to_lines [] ic

(* Return the string representation of a list *)
let string_of_list string_of_elt delim l =
  String.concat delim (List.map string_of_elt l)

(* Get a string from a list of characters *)
let string_of_chars l = string_of_list (fun c -> Printf.sprintf "%c" c) "" l
