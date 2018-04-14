(* Find the index and the value of the largest elemnt in an array *)
let find_max arr =
  let max_index_and_val (cur_idx, largest_idx, largest) x =
    if x > largest then (cur_idx + 1, cur_idx, x) else (cur_idx + 1, largest_idx, largest)
  in
    let _, idx, largest = Array.fold_left max_index_and_val (0, -1, min_int) arr
    in idx, largest

(* Count the redistribution cycles before reaching a state seen before and the
 * size of the loop for that state *)
let redistribution_cycles banks =
  let banks_array = Array.of_list banks in
  let size = Array.length banks_array in
  let rec distribute blocks pos =
    if blocks = 0 then ()
    else if pos >= size then distribute blocks 0
    else
      let () = banks_array.(pos) <- banks_array.(pos) + 1 in
      distribute (blocks - 1) (pos + 1)
  in
  let rec count_cycles seen_before cycles =
    match List.assoc_opt (Array.to_list banks_array) seen_before with
    | Some iter -> (cycles, cycles - iter) 
    | _ ->
      let snapshot = (Array.to_list banks_array, cycles) in
      let index, largest = find_max banks_array in
      let () = banks_array.(index) <- 0 in
      let () = distribute largest (index + 1) in
      count_cycles (snapshot :: seen_before) (cycles + 1)
  in count_cycles [] 0

