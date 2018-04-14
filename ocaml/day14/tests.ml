open Test
open Defragmenter

let () =
  let key = "flqrgnkx"
  and rows = 128 in
  let tests = [
    (used_squares rows key) = 8108;
    (regions rows key) = 1242
  ] in
  test_suite tests
