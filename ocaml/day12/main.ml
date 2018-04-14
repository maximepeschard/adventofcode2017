open Io
open Pipes

let file = Sys.argv.(1)

let () =
  let programs_str = read_lines file in
  let result_part1 = group_size programs_str 0 in
  let result_part2 = group_count programs_str in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
