open Test
open Pipes

let () =
  let progs_str = [
    "0 <-> 2";
    "1 <-> 1";
    "2 <-> 0, 3, 4";
    "3 <-> 2, 4";
    "4 <-> 2, 3, 6";
    "5 <-> 6";
    "6 <-> 4, 5"
  ] in
  let tests = [
    (group_size progs_str 0) = 6;
    (group_count progs_str) = 2
  ] in
  test_suite tests
