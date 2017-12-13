open Test
open Firewall

let () =
  let firewall_str = [
    "0: 3";
    "1: 2";
    "4: 4";
    "6: 4"
  ] in
  let tests = [
    (trip_severity firewall_str) = 24;
    (first_safe_trip firewall_str) = 10;
  ] in
  test_suite tests
