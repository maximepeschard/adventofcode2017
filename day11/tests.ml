open Test
open Hex

let () =
  let res11, res12 = furthest_and_steps (Stream.of_string "ne,ne,ne")
  and res21, res22 = furthest_and_steps (Stream.of_string "ne,ne,sw,sw")
  and res31, res32 = furthest_and_steps (Stream.of_string "ne,ne,s,s")
  and res41, res42 = furthest_and_steps (Stream.of_string "se,sw,se,sw,sw") in
  let tests = [
    res11 = 3; res21 = 2; res31 = 2; res41 = 3;
    res12 = 3; res22 = 0; res32 = 2; res42 = 3
  ] in
  test_suite tests
