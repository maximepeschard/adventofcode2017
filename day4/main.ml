#use "../common/io.ml"
#use "passphrase.ml"

let file = "input.txt"

let () =
  let passphrases = read_lines file in
  let result_part1 = count_valid_1 passphrases in
  let result_part2 = count_valid_2 passphrases in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
