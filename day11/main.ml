open Hex

let file = Sys.argv.(1)

let () =
  let ic = open_in file in
  let stream = Stream.of_channel ic in
  let result_part2, result_part1 = furthest_and_steps stream in
  close_in ic;
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
