#load "str.cma"
#use "../common/io.ml"
#use "memory.ml"

let file = "input.txt"

let to_int_list str =
  List.map int_of_string (Str.split (Str.regexp "[^0-9]+") str)

let () =
  let banks = to_int_list (List.hd (read_lines file)) in
  let result_part1, result_part2 = redistribution_cycles banks in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
