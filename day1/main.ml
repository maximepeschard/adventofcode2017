#use "captcha.ml"

let file = "input.txt"

let to_int_list str =
    let rec to_int_list_rec idx acc =
        if idx < 0 then acc
        else to_int_list_rec (idx - 1) (((int_of_char str.[idx]) - 48) :: acc)
    in to_int_list_rec ((String.length str) - 1) []

let () =
    let ic = open_in file in
    try
        let line = input_line ic in
        let digits = to_int_list line in
        let result = captcha digits in
        print_endline (string_of_int result);
        flush stdout;
        close_in ic
    with e ->
        close_in_noerr ic;
        raise e
