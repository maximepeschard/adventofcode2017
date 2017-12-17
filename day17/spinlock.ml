(* Insert a value in a list at position pos *)
let insert pos value l =
  let rec insert_aux idx acc l =
    match idx, l with
    | i, _ when i = pos -> List.rev_append acc (value :: l)
    | _, hd::tl -> insert_aux (idx + 1) (hd :: acc) tl
    | _, _ -> failwith "insert position must be less than or equal to the size"
  in insert_aux 0 [] l

(* Execute a spinlock circular insert *)
let circular_insert pos steps value l =
  let insert_pos = ((pos + steps) mod (List.length l)) + 1 in
  insert_pos, insert insert_pos value l

(* Execute the spinlock process iters times with a given number of steps *)
let spinlock steps iters =
  let rec spinlock_loop iter pos buffer =
    if iter = iters then pos, buffer
    else
      let new_pos, new_buffer = circular_insert pos steps (iter + 1) buffer in
      spinlock_loop (iter + 1) new_pos new_buffer
  in spinlock_loop 0 0 [0]

let spinlock_value_after steps iters =
  let final_pos, final_buffer = spinlock steps iters in
  List.nth final_buffer (final_pos + 1)
