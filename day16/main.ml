open Permutations

let file = Sys.argv.(1)

let () =
  let nb_programs = 16 in
  let result_part1 = dance_1 nb_programs file
  and result_part2 = dance_2 1000000000 nb_programs file in
  print_endline (String.concat "" result_part1);
  print_endline (String.concat "" result_part2);
  flush stdout;
