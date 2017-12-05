#use "../common/test.ml"
#use "passphrase.ml";;

let () =
  let passphrases_1 = [
    "aa bb cc dd ee";
    "aa bb cc dd aa";
    "aa bb cc dd aaa"
  ]
  and passphrases_2 = [
    "abcde fghij";
    "abcde xyz ecdab";
    "a ab abc abd abf abj";
    "iiii oiii ooii oooi oooo";
    "oiii ioii iioi iiio"
  ] in
  let tests = [
    (count_valid_1 passphrases_1) = 2;
    (count_valid_2 passphrases_2) = 3
  ] in
  test_suite tests
