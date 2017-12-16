open Generators

(* NB : this is the puzzle input *)
let init_a, init_b = 618, 814

let () =
  let factor_a, factor_b = 16807, 48271
  and div = 2147483647
  and bits = 16 in
  let result_part1 = judge_count_1 40000000 bits init_a init_b factor_a factor_b div
  and result_part2 = judge_count_2 5000000 bits init_a init_b factor_a factor_b div in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
