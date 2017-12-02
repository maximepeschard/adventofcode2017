#load "str.cma"
#use "checksum.ml"

let file = "input.txt"

let to_int_list str =
    List.map int_of_string (Str.split (Str.regexp "[^0-9]+") str)

let to_spreadsheet filename =
    let ic = open_in filename in
    let rec file_to_lines acc ic =
        match input_line ic with
        | line -> file_to_lines (line :: acc) ic
        | exception End_of_file -> close_in ic; List.rev acc
    in List.map to_int_list (file_to_lines [] ic)

let () =
    let spreadsheet = to_spreadsheet file in
    let result = checksum spreadsheet in
    print_endline (string_of_int result)
