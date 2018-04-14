open Io
open Hash

let file = Sys.argv.(1)

let () =
  let lengths_str = List.hd (read_lines file)
  and size = 256
  and block_size = 16
  and rounds = 64
  and suffix = [17; 31; 73; 47; 23] in
  let result_part1 = hash_1 size lengths_str
  and result_part2 = hash_2 size block_size rounds suffix lengths_str in
  print_endline (string_of_int result_part1);
  print_endline result_part2;
  flush stdout;
