open Defragmenter

let () =
  let key = "ugkiagan"
  and rows = 128 in
  let result_part1 = used_squares rows key
  and result_part2 = regions rows key in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
