#load "str.cma"

(* Split a string into (whitespace separated) words *)
let to_word_list phrase =
  Str.split (Str.regexp "[ \t]+") phrase

(* Split a word into characters *)
let explode word =
  let rec aux word acc =
    match word with
    | "" -> acc
    | _ -> aux (String.sub word 1 ((String.length word) - 1)) (word.[0] :: acc)
  in aux word []

(* Check if a list contains duplicates *)
let rec contains_duplicates xs =
  match xs with
  | [] -> false
  | hd::tl -> if List.mem hd tl then true else contains_duplicates tl

(* Check if 'words' contains an anagram of 'word' *)
let rec anagrams word words =
  let chars = List.sort Char.compare (explode word) in
  match words with
  | [] -> false
  | hd::tl -> chars = (List.sort Char.compare (explode hd)) || anagrams word tl

(* Check if a list of words contains anagrams *)
let rec contains_anagrams words =
  match words with
  | [] -> false
  | hd::tl -> anagrams hd tl || contains_anagrams tl

(* Check if a passphrase is valid wrt. a validation function *)
let is_valid passphrase validation_func =
  let words = to_word_list passphrase in not (validation_func words)

(* Count valid passphrases in a list of phrases *)
let count_valid passphrases validation_func =
  let add_valid acc passphrase =
    if is_valid passphrase validation_func then acc + 1 else acc
  in List.fold_left add_valid 0 passphrases

let count_valid_1 = fun pp -> count_valid pp contains_duplicates
let count_valid_2 = fun pp -> count_valid pp contains_anagrams
