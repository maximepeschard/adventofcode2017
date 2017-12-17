open Spinlock

let steps, iters = 337, 2017

let () =
  let result_part1 = spinlock_value_after steps iters in
  print_endline (string_of_int result_part1);
  flush stdout;
