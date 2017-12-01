(* Get the offset version of a circular list *)
let rec circular xs offset =
    match xs with
    | [] -> []
    | hd::tl -> if offset <= 0 then xs else circular (tl @ [hd]) (offset - 1) 

(* Given a sequence of digits, compute the sum of all digits that match
 * the digit located offset digits after in the sequence *)
let captcha digits offset =
    match digits with
    | [] -> 0
    | hd::tl ->
            let addIfEqual sum m n =
                if m == n then sum + m else sum
            in List.fold_left2 addIfEqual 0 digits (circular digits offset)
