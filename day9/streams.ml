(* Remove canceled characters and the '!' doing the canceling from a stream *)
let remove_canceled s = Str.global_replace (Str.regexp "!.") "" s

(* Compute the score of a stream and the number of non-canceled garbage characters *)
let score_and_garbage_count stream =
  (* context = 0 for group, 1 for garbage *)
  let rec aux context outer s_acc g_acc s =
    match Stream.peek s with
    | None -> s_acc, g_acc
    | Some c ->
        let () = Stream.junk s in
        (match c with
        | '{' when context = 0 -> aux context (outer + 1) (s_acc + outer + 1) g_acc s
        | '}' when context = 0 -> aux context (outer - 1) s_acc g_acc s
        | '<' when context = 0 -> aux 1 outer s_acc g_acc s
        | '>' -> aux 0 outer s_acc g_acc s
        | _ when context = 1 -> aux 1 outer s_acc (g_acc + 1) s
        | _ -> aux context outer s_acc g_acc s)
  in aux 0 0 0 0 (Stream.of_string (remove_canceled stream))
