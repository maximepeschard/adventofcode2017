open Test
open Maze

let () =
  let maze = [0; 3; 0; 1; -3] in
  let tests = [(exit_steps_1 maze) = 5; (exit_steps_2 maze) = 10] in
  test_suite tests
