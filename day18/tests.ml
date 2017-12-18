open Test
open Duet

let () =
  let instructions = [
    "set a 1";
    "add a 2";
    "mul a a";
    "mod a 5";
    "snd a";
    "set a 0";
    "rcv a";
    "jgz a -1";
    "set a 1";
    "jgz a -2"
  ] in
  let tests = [(first_rcv instructions) = 4] in
  test_suite tests
