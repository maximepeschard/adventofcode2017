let is_odd n = (n mod 2) == 1

let next_odd_root n =
    let candidate = int_of_float (ceil (sqrt (float_of_int n))) in
    if is_odd candidate then candidate else candidate + 1

let nearest ns n =
    let compare_dist dist_ref u =
        let dist = abs (u - n) in
        if dist < dist_ref then dist else dist_ref
    in List.fold_left compare_dist max_int ns

let distance n =
    let root = next_odd_root n in
    let upper = root * root
    and base_dist = root / 2 in
    let cross = List.map (fun p -> upper - (base_dist + p * (root - 1))) [0;1;2;3] in
    base_dist + (nearest cross n)
