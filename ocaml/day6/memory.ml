(* Apply a function to the nth element of a list *)
let mapn n xs func =
  let rec aux xs pos acc =
    match xs with
    | [] -> List.rev acc
    | hd::tl ->
        let new_elt = if pos = n then func hd else hd in
        aux tl (pos + 1) (new_elt :: acc)
  in aux xs 0 []

  (* Find the index and the value of the largest elemnt in an list *)
let find_max xs =
  let max_index_and_val (cur, index, largest) x =
    if x > largest then (cur + 1, cur, x) else (cur + 1, index, largest)
  in
    let _, index, largest = List.fold_left max_index_and_val (0, -1, min_int) xs
    in index, largest

(* Distribute blocks among the banks, starting at index 'pos' *)
let rec distribute banks blocks pos =
  if blocks = 0 then banks
  else if pos >= List.length banks then distribute banks blocks 0
  else
    let new_banks = mapn pos banks (fun x -> x + 1)
    in distribute new_banks (blocks - 1) (pos + 1)

(* Count the redistribution cycles before reaching a state seen before and the
 * size of the loop for that state *)
let redistribution_cycles banks =
  let rec count_cycles banks seen_before cycles =
    match List.assoc_opt banks seen_before with
    | Some iter -> (cycles, cycles - iter)
    | _ ->
      let snapshot = (banks, cycles) in
      let index, largest = find_max banks in
      let new_banks = distribute (mapn index banks (fun x -> 0)) largest (index + 1) in
      count_cycles new_banks (snapshot :: seen_before) (cycles + 1)
  in count_cycles banks [] 0
