(* Get the offset version of a circular list *)
let circular offset l =
  let rec aux l acc offset =
    match l, acc, offset with
    | [], [], _ -> []
    | [], _, o when o <= 0 -> List.rev acc
    | [], _, _ -> aux (List.rev acc) [] offset
    | hd::tl, _, o when o <= 0 -> l @ (List.rev acc)
    | hd::tl, _, _ -> aux tl (hd :: acc) (offset - 1)
  in aux l [] offset

(* Given a sequence of digits, compute the sum of all digits that match
 * the digit located offset digits after in the sequence *)
let captcha digits offset =
  let add_if_equal sum m n = if m == n then sum + m else sum in
  List.fold_left2 add_if_equal 0 digits (circular offset digits)

let captcha_1 digits = captcha digits 1
let captcha_2 digits = captcha digits (List.length digits / 2)
