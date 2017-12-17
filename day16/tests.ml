open Test
open Permutations

let input_tests = Sys.argv.(1)

let () =
  let nb_programs = 5 in
  let tests = [(dance_1 nb_programs input_tests) = ["b";"a";"e";"d";"c"]] in
  test_suite tests
