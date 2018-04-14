let get k registers =
  match List.assoc_opt k registers with
  | None -> 0
  | Some v -> v

let value regs s =
  try int_of_string s with _ -> get s regs

let apply operation key registers =
  let rec execute_rec registers acc =
    match registers with
    | [] -> (key, operation 0) :: acc
    | (k, v)::tl when k = key -> (k, operation v) :: (acc @ tl)
    | (k, v)::tl -> execute_rec tl ((k, v) :: acc)
  in execute_rec registers []

let execute reg s rcv pos instruction =
  let split = Str.split (Str.regexp "[ \t]+") instruction in
  match List.hd split with
  | "set" ->
      apply (fun n -> value reg (List.nth split 2)) (List.nth split 1) reg, s, rcv, pos + 1
  | "add" ->
      apply (fun n -> n + (value reg (List.nth split 2))) (List.nth split 1) reg, s, rcv, pos + 1
  | "mul" ->
      apply (fun n -> n * (value reg (List.nth split 2))) (List.nth split 1) reg, s, rcv, pos + 1
  | "mod" ->
      apply (fun n -> n mod (value reg (List.nth split 2))) (List.nth split 1) reg, s, rcv, pos + 1
  | "snd" -> reg, get (List.nth split 1) reg, rcv, pos + 1
  | "rcv" when get (List.nth split 1) reg <> 0 -> reg, s, Some s, pos + 1
  | "jgz" when get (List.nth split 1) reg > 0 -> reg, s, rcv, pos + (value reg (List.nth split 2))
  | _ -> reg, s, rcv, pos + 1

let first_rcv instructions =
  let rec loop reg s rcv pos =
    match rcv with
    | Some v -> v
    | None ->
        let reg, s, rcv, pos = execute reg s rcv pos (List.nth instructions pos)
        in loop reg s rcv pos
  in loop [] (-1) None 0
