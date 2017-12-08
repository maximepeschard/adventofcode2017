#use "../common/test.ml"
#use "registers.ml"

let () =
  let instructions = [
    "b inc 5 if a > 1";
    "a inc 1 if b < 5";
    "c dec -10 if a >= 1";
    "c inc -20 if c == 10"
  ] in
  let max_all, max_final = largest_register instructions in
  let test1 = max_final = 1
  and test2 = max_all = 10 in
  let tests = [test1; test2] in
  test_suite tests
