#use "../common/io.ml"
#use "streams.ml"

let file = "input.txt"

let () =
  let stream = List.hd (read_lines file) in
  let result_part1, result_part2 = score_and_garbage_count stream in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
