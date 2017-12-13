open Io
open Firewall

let file = Sys.argv.(1)

let () =
  let firewall_str = read_lines file in
  let result_part1 = trip_severity firewall_str
  and result_part2 = first_safe_trip firewall_str in
  print_endline (string_of_int result_part1);
  print_endline (string_of_int result_part2);
  flush stdout;
