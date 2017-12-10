open Io
open Checksum

let file = Sys.argv.(1)

let to_int_list str =
  List.map int_of_string (Str.split (Str.regexp "[^0-9]+") str)

let () =
  let spreadsheet = List.map to_int_list (read_lines file) in
  let result_part1 = checksum_1 spreadsheet
  and result_part2 = checksum_2 spreadsheet in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
