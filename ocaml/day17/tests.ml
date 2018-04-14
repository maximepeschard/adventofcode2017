open Test
open Spinlock

let () =
  let steps = 3
  and iters = 2017 in
  let tests = [(spinlock_after_last steps iters) = 638] in
  test_suite tests
