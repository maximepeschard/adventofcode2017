#use "../common/test.ml"
#use "memory.ml"

let () =
  let banks = [0; 2; 7; 0] in
  let tests = [(redistribution_cycles banks) = (5, 4)] in
  test_suite tests
