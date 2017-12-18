open Io
open Duet

let file = Sys.argv.(1)

let () =
  let instructions = read_lines file in
  let result_part1 = first_rcv instructions in
  print_endline (string_of_int result_part1);
  flush stdout;
