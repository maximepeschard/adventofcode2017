open Test
open Captcha

let () =
  let tests = [
    (captcha_1 [1;1;2;2]) = 3;
    (captcha_1 [1;1;1;1]) = 4;
    (captcha_1 [1;2;3;4]) = 0;
    (captcha_1 [9;1;2;1;2;1;2;9]) = 9;
    (captcha_2 [1;2;1;2]) = 6;
    (captcha_2 [1;2;2;1]) = 0;
    (captcha_2 [1;2;3;4;2;5]) = 4;
    (captcha_2 [1;2;3;1;2;3]) = 12;
    (captcha_2 [1;2;1;3;1;4;1;5]) = 4]
  in test_suite tests
