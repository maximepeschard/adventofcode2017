#load "str.cma"

(* Build a tower (a list of (name, weight, list of children names) from input *)
let to_tower progs_info =
  let to_info prog =
    let info = Str.split (Str.regexp " -> ") prog in
    let children =
      if List.length info = 2 then Str.split (Str.regexp ", ") (List.nth info 1)
      else []
    in
    let erase_parens = Str.global_replace (Str.regexp "[()]") "" in
    let name_weight = List.map erase_parens (Str.split (Str.regexp " ") (List.hd info))
    in (List.hd name_weight, (int_of_string (List.nth name_weight 1), children))
  in List.map to_info progs_info

(* Get the children names of a program in the tower *)
let children program tower =
  match List.assoc_opt program tower with
  | None -> []
  | Some (weight, progs) -> progs

(* Get the parent name of a program in the tower *)
let rec parent program tower =
  match tower with
  | [] -> None
  | (prog, (weight, childr))::tl ->
      if List.mem program childr then Some prog
      else parent program tl

(* Get the weight of a program in a tower *)
let prog_weight program tower = fst (List.assoc program tower)

(* Get the bottom program of a tower *)
let bottom_program tower =
  let keep_orphan acc node =
    match parent (fst node) tower with
    | None -> Some (fst node)
    | _ -> acc
  in List.fold_left keep_orphan None tower

type tree = Node of (string * int * tree list)

(* Build a program tree from a tower *)
let make_tree tower =
  let root =
    match bottom_program tower with
    | None -> failwith "no root"
    | Some prog -> prog
  in
  let rec build p w =
    match children p tower with
    | [] -> Node(p, w, [])
    | cs -> Node(p, w, List.map (fun c -> build c (prog_weight c tower)) cs)
  in build root (prog_weight root tower)

(* Get the elements of a list that occur only once in that list *)
let rec unique xs seen res idx =
  match xs with
  | [] -> res
  | hd::tl ->
      if List.mem hd seen then unique tl seen (List.filter (fun x -> snd x != hd) res) (idx + 1)
      else unique tl (hd :: seen) ((idx, hd) :: res) (idx + 1)

(* Get the weight of a tree (ie. the weight of its root) *)
let weight (Node(_, w, _)) = w

(* Get the corrected weight of a faulty program in the tree
 * NB: we assume that there is at most one such program *)
let faulty (Node(p, w, ch)) =
  let rec faulty_aux (Node(p, w, ch)) =
    match ch with
    | [] -> (false, w)
    | _ ->
        (let res_ch = List.map faulty_aux ch in
        match List.filter fst res_ch with
        | [] ->
            (match unique (List.map snd res_ch) [] [] 0 with
            | [] ->
                let add_weight acc res_c = acc + (snd res_c) in
                (false, w + (List.fold_left add_weight 0 res_ch))
            | (idx, wei)::[] ->
                let faulty_child = List.nth ch idx in
                let correct = snd (List.find (fun x -> snd x != wei) res_ch) in
                let corrected =  (weight faulty_child) + correct - wei in
                (true, corrected)
            | any -> failwith "no more than one is faulty")
        | [(_, corr_weight)] -> (true, corr_weight)
        | _ -> failwith "no more than one is faulty")
  in
  match faulty_aux (Node(p, w, ch)) with
  | (false, _) -> None
  | (true, corrected_weight) -> Some corrected_weight
