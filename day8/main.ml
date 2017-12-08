#use "../common/io.ml"
#use "registers.ml"

let file = "input.txt"

let () =
  let instructions = read_lines file in
  let result_part2, result_part1 = largest_register instructions in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
