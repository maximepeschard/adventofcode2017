(* string -> string list *)
let to_word_list phrase =
    Str.split (Str.regexp "[ \t]+") phrase

(* string -> char list *)
let explode word =
    let rec aux word acc =
        match word with
        | "" -> acc
        | _ -> aux (String.sub word 1 ((String.length word) - 1)) (word.[0] :: acc)
    in aux word []

(* 'a list -> bool *)
let rec contains_duplicates xs =
    match xs with
    | [] -> false
    | hd::tl -> if List.mem hd tl then true
                else contains_duplicates tl

(* 'a -> 'a list -> 'a list list *)
let insert_all_pos x xs =
    let rec aux x acc prec rem =
        match rem with
        | [] -> (prec @ [x]) :: acc
        | hd::tl -> aux x ((prec @ (x :: hd :: tl)) :: acc) (prec @ [hd]) tl
    in aux x [] [] xs

(* 'a list -> 'a list list *)
let rec permutations xs =
    match xs with
    | [] -> []
    | hd::[] -> [[hd]]
    | hd::tl -> List.flatten (List.map (insert_all_pos hd) (permutations tl))

(* string list -> bool *)
let rec contains_anagrams words =
    match words with
    | [] -> false
    | hd::tl -> let anagrams = permutations (explode hd) in
                if List.exists (fun ana -> List.mem ana (List.map explode tl)) anagrams then true
                else contains_anagrams tl

(* string -> (string list -> bool) -> bool *)
let is_valid passphrase validation_func =
    let words = to_word_list passphrase in
    not (validation_func words)

(* string list -> (string list -> bool) -> int *)
let count_valid passphrases validation_func =
    let add_valid acc passphrase =
        if is_valid passphrase validation_func then acc + 1 else acc
    in List.fold_left add_valid 0 passphrases

let count_valid_1 = fun pp -> count_valid pp contains_duplicates
let count_valid_2 = fun pp -> count_valid pp contains_anagrams
