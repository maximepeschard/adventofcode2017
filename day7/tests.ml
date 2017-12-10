open Test
open Programs

let () =
  let prog_infos = [
    "pbga (66)";
    "xhth (57)";
    "ebii (61)";
    "havc (66)";
    "ktlj (57)";
    "fwft (72) -> ktlj, cntj, xhth";
    "qoyq (66)";
    "padx (45) -> pbga, havc, qoyq";
    "tknk (41) -> ugml, padx, fwft";
    "jptl (61)";
    "ugml (68) -> gyxo, ebii, jptl";
    "gyxo (61)";
    "cntj (57)"
  ] in
  let tower = to_tower prog_infos in
  let test1 =
    match bottom_program tower with
    | None -> false
    | Some prog_name -> prog_name = "tknk"
  in
  let test2 =
    match faulty (make_tree tower) with
    | None -> false
    | Some weight -> weight = 60
  in
  let tests = [test1; test2] in
  test_suite tests
