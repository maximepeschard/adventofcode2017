open Test
open Generators

let () =
  let factor_a, factor_b = 16807, 48271
  and init_a, init_b = 65, 8921
  and div = 2147483647
  and bits = 16 in
  let tests = [
    (judge_count_1 5 bits init_a init_b factor_a factor_b div) = 1;
    (judge_count_1 40000000 bits init_a init_b factor_a factor_b div) = 588;
    (judge_count_2 5 bits init_a init_b factor_a factor_b div) = 0;
    (judge_count_2 5000000 bits init_a init_b factor_a factor_b div) = 309;
  ] in
  test_suite tests
