#load "str.cma"

type 'a operation = 'a -> 'a -> 'a
type 'a register = Register of 'a
type 'a condition = Condition of string * ('a -> 'a -> bool) * 'a
type 'a instruction = Instruction of string * 'a operation * 'a * 'a condition

(* Parse an instruction line *)
let parse instruction =
  let split = Str.split (Str.regexp "[ \t]+") instruction in
  let op =
    match List.nth split 1 with
    | "inc" -> (+)
    | "dec" -> (-)
    | _ -> failwith "unknown operation"
  in
  let cop =
    match List.nth split 5 with
    | "<" -> (<)
    | ">" -> (>)
    | "<=" -> (<=)
    | ">=" -> (>=)
    | "==" -> (=)
    | "!=" -> (!=)
    | _ -> failwith "unknown comparison operator"
  in
  let cond = Condition(List.nth split 4, cop, int_of_string (List.nth split 6)) in
  Instruction(List.nth split 0, op, int_of_string (List.nth split 2), cond)

(* Get a register from the store *)
let get name store = List.assoc_opt name store

(* Set the value of a register in the store *)
let set name value store =
  let rec set_aux store acc =
    match store with
    | [] -> (name, Register(value)) :: acc
    | (n, Register(v))::tl ->
        if n = name then ((n, Register(value)) :: acc) @ tl
        else set_aux tl ((n, Register(v)) :: acc)
  in set_aux store []

(* Get the maximum value of the registers in a store *)
let maximum store =
  let cmp acc (n, Register(v)) = max acc v in
  List.fold_left cmp min_int store

(* Evaluate a condition against a register store *)
let evaluate (Condition(n, f, v)) store =
  match get n store with
  | Some Register(value) -> f value v
  | _ -> failwith "unknown register"

(* Process an instruction given a store, producing a new store *)
let process store (Instruction(n, op, v, Condition(m, f, w))) =
  let store, n_val, m_val =
    match (get n store), (get m store) with
    | None, None -> (set n 0 (set m 0 store)), 0, 0
    | None, Some Register(y) -> (set n 0 store), 0, y
    | Some Register(x), None -> (set m 0 store), x, 0
    | Some Register(x), Some Register(y) -> store, x, y
  in
  if evaluate (Condition(m, f, w)) store then set n (op n_val v) store
  else store

(* Process a list of instructions given an initial store, producing a final store *)
let rec process_list instructions store =
  let aux (s, m) i = let new_s = process s i in (new_s, (maximum new_s)::m) in
  let fs, ms = List.fold_left aux (store, [maximum store]) instructions in
  fs, List.rev ms

(* Get the maximum value and the last value of a list of integers *)
let max_and_last xs =
  let rec aux xs (m, l) =
    match xs with
    | [] -> (m, l)
    | hd::tl -> aux tl (max m hd, hd)
  in aux xs (min_int, min_int)

(* Get the highest register value held during the whole process and the highest
 * register value in the final store *)
let largest_register instructions =
  let final_store, maximums = process_list (List.map parse instructions) [] in
  max_and_last maximums
