#use "../common/io.ml"
#use "maze.ml"

let file = "input.txt"

let () =
  let maze = List.map int_of_string (read_lines file) in
  let result_part1 = exit_steps_1 maze in
  let result_part2 = exit_steps_2 maze in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
