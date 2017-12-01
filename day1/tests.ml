#use "captcha.ml";;

(captcha [1;1;2;2]) == 3;;

(captcha [1;1;1;1]) == 4;;

(captcha [1;2;3;4]) == 0;;

(captcha [9;1;2;1;2;1;2;9]) == 9;;
