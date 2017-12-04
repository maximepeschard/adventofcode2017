#use "passphrase.ml"

let file = "input.txt"

let to_lines filename =
    let ic = open_in filename in
    let rec file_to_lines acc ic =
        match input_line ic with
        | line -> file_to_lines (line :: acc) ic
        | exception End_of_file -> close_in ic; List.rev acc
    in file_to_lines [] ic

let () =
    let passphrases = to_lines file in
    let result_part1 = count_valid_1 passphrases in
    let result_part2 = count_valid_2 passphrases in
    print_endline (string_of_int result_part1);
    print_endline (string_of_int result_part2);
    flush stdout;
