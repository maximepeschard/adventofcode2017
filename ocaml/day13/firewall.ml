(* Parse a layer string with format "depth : range" *)
let parse_layer s =
  let depth_range = List.map int_of_string (Str.split (Str.regexp "[ \t]*:[ \t]*") s)
  in (List.hd depth_range, List.nth depth_range 1)

(* Get the position of a layer scanner given a time and a range *)
let scanner_position range picoseconds =
  if picoseconds mod ((range - 1) * 2) <= (range - 1) then picoseconds mod ((range - 1) * 2)
  else (range - 1) - (picoseconds mod (range - 1))

(* Get the severity of a packet trip and the layer that caught it *)
let rec trip_severity_delay firewall picoseconds severity delay caught_at =
    match firewall with
    | [] -> severity, caught_at
    | (d, r)::tl ->
        if d != picoseconds then
          trip_severity_delay firewall (picoseconds + 1) severity delay caught_at
        else
          if (scanner_position r (picoseconds + delay)) = 0 then
            trip_severity_delay tl (picoseconds + 1) (severity + d * r) delay (d :: caught_at)
          else
            trip_severity_delay tl (picoseconds + 1) severity delay caught_at

(* Get the severity of a packet trip given a firewall description *)
let trip_severity firewall_str =
  fst (trip_severity_delay (List.map parse_layer firewall_str) 0 0 0 [])

(* Get the minimal delay for a safe packet trip given a firewall description
 * NB : kind of dumb brute force, a slightly better approach could be to use a
 * version of trip_severity_delay that immediately stops when a packet is
 * caught *)
let first_safe_trip firewall_str =
  let firewall = List.map parse_layer firewall_str in
  let rec aux delay =
    if List.length (snd (trip_severity_delay firewall 0 0 delay [])) = 0 then delay
    else aux (delay + 1)
  in aux 0
