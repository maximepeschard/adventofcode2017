module ProgSet = Set.Make(
  struct
    type t = int
    let compare = Pervasives.compare
  end
)

(* Parse a program and its children from a string "j <-> k, l, m" *)
let prog_of_string s =
  let prog_children = Str.split (Str.regexp "[ \t]*<->[ \t]*") s in
  let prog = int_of_string (List.hd prog_children) in
  let children = Str.split (Str.regexp ",[ \t]*") (List.nth prog_children 1) in
  prog, List.map int_of_string children

(* Get programs that are in the group containing prog from a list of programs *)
let rec group progs prog acc =
  if ProgSet.mem prog acc then acc
  else
    match List.assoc_opt prog progs with
    | None -> ProgSet.singleton prog
    | Some children ->
        let fun_ch accset c =
          ProgSet.union accset (group progs c (ProgSet.add prog acc))
        in
        let res_children = List.fold_left fun_ch ProgSet.empty children in
        ProgSet.add prog res_children

(* Get all groups from a list of programs *)
let rec groups progs acc =
  match progs with
  | [] -> acc
  | (p,_)::tl ->
      if List.exists (fun s -> ProgSet.mem p s) acc then groups tl acc
      else groups tl ((group progs p ProgSet.empty) :: acc)

(* Get the size of the group containing prog *)
let group_size progs_str prog =
  let progs = List.map prog_of_string progs_str in
  ProgSet.cardinal (group progs prog ProgSet.empty)

(* Get the total number of groups given a list of programs *)
let group_count progs_str =
  let progs = List.map prog_of_string progs_str in
  List.length (groups progs [])
