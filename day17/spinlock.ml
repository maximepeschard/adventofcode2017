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

(* Execute the spinlock process iters times and return the value after the last
 * inserted one in the buffer *)
let spinlock_after_last steps iters =
  let rec spinlock_loop iter pos buffer =
    if iter = iters then pos, buffer
    else
      let new_pos, new_buffer = circular_insert pos steps (iter + 1) buffer in
      spinlock_loop (iter + 1) new_pos new_buffer
  in
  let final_pos, final_buffer = spinlock_loop 0 0 [0] in
  List.nth final_buffer (final_pos + 1)

(* Return the value after zero in the buffer, after iters spinlock rounds
 * NB: We could probably generalize this to any number of the bufffer by
 * delaying the tracking until the corresponding iteration... *)
let spinlock_after_zero steps iters =
  let rec spinlock_loop iter pos pos_zero after_zero buf_size =
    if iter = iters then after_zero
    else
      let insert_pos = ((pos + steps) mod buf_size) + 1 in
      if insert_pos = pos_zero + 1 then
        spinlock_loop (iter + 1) insert_pos pos_zero (iter + 1) (buf_size + 1)
      else if insert_pos <= pos_zero then
        spinlock_loop (iter + 1) insert_pos (pos_zero + 1) after_zero (buf_size + 1)
      else
        spinlock_loop (iter + 1) insert_pos pos_zero after_zero (buf_size + 1)
  in spinlock_loop 0 0 0 (-1) 1
