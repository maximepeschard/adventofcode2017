#use "../common/test.ml"
#use "checksum.ml";;

let () =
  let spreadsheet_1 = [
    [5; 1; 9; 5];
    [7; 5; 3];
    [2; 4; 6; 8]
  ]
  and spreadsheet_2 = [
    [5; 9; 2; 8];
    [9; 4; 7; 3];
    [3; 8; 6; 5]
  ] in
  let tests = [(checksum_1 spreadsheet_1) = 18; (checksum_2 spreadsheet_2) = 9]
  in test_suite tests
