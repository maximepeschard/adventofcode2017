#use "../common/io.ml"
#use "captcha.ml"

let file = "input.txt"

let to_int_list str =
  let rec to_int_list_rec idx acc =
    if idx < 0 then acc
    else to_int_list_rec (idx - 1) (((int_of_char str.[idx]) - 48) :: acc)
  in to_int_list_rec ((String.length str) - 1) []

let () =
  let line = List.hd (read_lines file) in
  let digits = to_int_list line in
  let result_part1 = captcha_1 digits
  and result_part2 = captcha_2 digits in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
