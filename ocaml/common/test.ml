(* Print the results of a test suite *)
let test_suite tests =
  let print_result index res =
    let human_res = if res then "ok" else "ko" in
    let words = ["Test"; (string_of_int (index + 1)); ":"; human_res] in
    print_endline (String.concat " " words)
  in List.iteri print_result tests; flush stdout;
