(* Get the next value of a generator *)
let rec generate criterion factor divisor previous =
  let candidate = (factor * previous) mod divisor in
  if criterion candidate then candidate
  else generate criterion factor divisor candidate

(* Compute the lowest bits of a number, as an integer *)
let lowest_bits bits n =
  let rec aux acc b pow n =
    if b = bits then acc
    else aux (acc + pow * (n mod 2)) (b + 1) (pow * 10) (n / 2)
  in aux 0 0 1 n

(* Count matching values of two generators *)
let judge_count iters bits crit_a crit_b init_a init_b factor_a factor_b div =
  let rec judge iter count prev_a prev_b =
    if iter = iters then count
    else
      let gen_a = generate crit_a factor_a div prev_a
      and gen_b = generate crit_b factor_b div prev_b in
      let bin_a, bin_b = lowest_bits bits gen_a, lowest_bits bits gen_b in
      judge (iter + 1) (if bin_a = bin_b then count + 1 else count) gen_a gen_b
  in judge 0 0 init_a init_b

let judge_count_1 iters bits init_a init_b factor_a factor_b div =
  let crit_a = fun x -> true
  and crit_b = fun x -> true in
  judge_count iters bits crit_a crit_b init_a init_b factor_a factor_b div

let judge_count_2 iters bits init_a init_b factor_a factor_b div =
  let crit_a = fun x -> (x mod 4) = 0
  and crit_b = fun x -> (x mod 8) = 0 in
  judge_count iters bits crit_a crit_b init_a init_b factor_a factor_b div
