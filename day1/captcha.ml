(* Given a sequence of digits, compute the sum of all digits that match the next
 * digit in the sequence *)
let captcha digits =
    match digits with
    | [] -> 0
    | hd::tl ->
            let addIfEqual sum m n =
                if m == n then sum + m else sum
            in List.fold_left2 addIfEqual 0 digits (tl @ [hd]);;
