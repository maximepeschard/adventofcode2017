(*
 * Kuddos to :
 * https://www.redblobgames.com/grids/hexagons/
 *)
type cardinal = North | East | South | West
type ordinal = Empty | Ord of cardinal * cardinal

(* Build a cardinal from a character *)
let card_of_char c =
  match c with
  | 'n' -> North
  | 'e' -> East
  | 's' -> South
  | 'w' -> West
  | _ -> failwith "illegal cardinal"

(* Build an ordinal from a list of characters *)
let ord_of_chars l =
  let size = List.length l in
  if size = 1 then let card = card_of_char (List.hd l) in Ord(card, card)
  else if size = 2 then Ord(card_of_char (List.hd l), card_of_char (List.nth l 1))
  else failwith "illegal ordinal"


(* Get the hexagonal direction vector for an ordinal
 * Directions are encoded as 3-tuples *)
let direction ord =
  match ord with
  | Ord(North, North) -> (1, 0, 1)
  | Ord(North, East) -> (1, 1, 0)
  | Ord(South, East) -> (0, 1, -1)
  | Ord(South, South) -> (-1, 0, -1)
  | Ord(South, West) -> (-1, -1, 0)
  | Ord(North, West) -> (0, -1, 1)
  | _ -> failwith "illegal direction"

(* Move in a direction from a position *)
let add position direction =
  let x, y, z = position
  and dx, dy, dz = direction in
  (x + dx, y + dy, z + dz)

(* Compute the (hexagonal) distance between two positions *)
let distance pos1 pos2 =
  let x1, y1, z1 = pos1
  and x2, y2, z2 = pos2 in
  max (abs (x2 - x1)) (max (abs (y2 - y1)) (abs (z2 - z1)))

(* Compute the distance of a position to the origin *)
let distance_origin pos =
  distance (0, 0, 0) pos

(* Parse a stream and return the maximal distance and the final position *)
let rec parse stream cur max_dist position =
  match (Stream.peek stream), (List.length cur) with
  | None, s when s = 0 -> max_dist, position
  | None, _ ->
      let new_pos = add position (direction (ord_of_chars (List.rev cur))) in
      (max max_dist (distance_origin new_pos)), new_pos
  | Some ',', _ ->
      Stream.junk stream;
      let new_pos = add position (direction (ord_of_chars (List.rev cur))) in
      parse stream [] (max max_dist (distance_origin new_pos)) new_pos
  | Some c, _ when List.mem c ['n';'e';'s';'w'] ->
      Stream.junk stream;
      parse stream (c :: cur) max_dist position
  | _, _ ->
      Stream.junk stream;
      parse stream cur max_dist position

(* Wrapper for 'parse' *)
let furthest_and_steps stream =
  let furthest, final_pos = parse stream [] 0 (0, 0, 0) in
  furthest, distance (0, 0, 0) final_pos
