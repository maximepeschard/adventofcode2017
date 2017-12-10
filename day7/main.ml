open Io
open Programs

let file = Sys.argv.(1)

let () =
  let prog_infos = read_lines file in
  let tower = to_tower prog_infos in
  let result_part1 = bottom_program tower in
  let result_part2 = faulty (make_tree tower) in
  match result_part1 with
  | None -> print_endline "error";
  | Some prog_name -> print_endline prog_name;
  match result_part2 with
  | None -> print_endline "error";
  | Some weight -> print_endline (string_of_int weight);
  flush stdout;
