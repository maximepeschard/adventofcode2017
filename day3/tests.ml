#use "../common/test.ml"
#use "memory.ml"

let () =
  let tests = [
    (distance 1) = 0;
    (distance 12) = 3;
    (distance 23) = 2;
    (distance 1024) = 31
  ] in
  test_suite tests
