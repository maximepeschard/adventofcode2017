open Io
open Registers

let file = Sys.argv.(1)

let () =
  let instructions = read_lines file in
  let result_part2, result_part1 = largest_register instructions in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
