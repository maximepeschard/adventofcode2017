(* Read a file and return the list of lines *)
let read_lines filename =
  let ic = open_in filename in
  let rec file_to_lines acc ic =
    match input_line ic with
    | line -> file_to_lines (line :: acc) ic
    | exception End_of_file -> close_in ic; List.rev acc
  in file_to_lines [] ic
