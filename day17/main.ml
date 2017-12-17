open Spinlock

let steps, iters_1, iters_2 = 337, 2017, 50000000

let () =
  let result_part1 = spinlock_after_last steps iters_1
  and result_part2 = spinlock_after_zero steps iters_2 in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
