open Test
open Streams

let () =
  let s1 = "{}"
  and s2 = "{{{}}}"
  and s3 = "{{},{}}"
  and s4 = "{{{},{},{{}}}}"
  and s5 = "{<a>,<a>,<a>,<a>}"
  and s6 = "{{<ab>},{<ab>},{<ab>},{<ab>}}"
  and s7 = "{{<!!>},{<!!>},{<!!>},{<!!>}}"
  and s8 = "{{<a!>},{<a!>},{<a!>},{<ab>}}"
  and s9 = "{<>}"
  and s10 = "{<random characters>}"
  and s11 = "{<<<<>}"
  and s12 = "{<{!>}>}"
  and s13 = "{<!!>}"
  and s14 = "{<!!!>>}"
  and s15 = "{<{o\"i!a,<{i<a>}"
  in
  let tests = [
    fst (score_and_garbage_count s1) = 1;
    fst (score_and_garbage_count s2) = 6;
    fst (score_and_garbage_count s3) = 5;
    fst (score_and_garbage_count s4) = 16;
    fst (score_and_garbage_count s5) = 1;
    fst (score_and_garbage_count s6) = 9;
    fst (score_and_garbage_count s7) = 9;
    fst (score_and_garbage_count s8) = 3;
    snd (score_and_garbage_count s9) = 0;
    snd (score_and_garbage_count s10) = 17;
    snd (score_and_garbage_count s11) = 3;
    snd (score_and_garbage_count s12) = 2;
    snd (score_and_garbage_count s13) = 0;
    snd (score_and_garbage_count s14) = 0;
    snd (score_and_garbage_count s15) = 10;
  ] in
  test_suite tests
