let row_diff row =
    let rec row_diff_rec smallest largest row =
        match row with
        | [] -> largest - smallest
        | hd::tl -> row_diff_rec (min smallest hd) (max largest hd) tl
    in row_diff_rec max_int min_int row

let rec row_div row =
    let rec search_div x xs acc =
        match xs with
        | [] -> acc
        | hd::tl -> let num = max hd x
                    and denom = min hd x in
                    let divisible = (num mod denom) == 0 in
                    if divisible then Some (num / denom) else search_div x tl acc
    in match row with
    | [] -> 0 (* should maybe fail here...  *)
    | hd::tl -> match search_div hd tl None with
                | None -> row_div tl
                | Some n -> n

let checksum spreadsheet row_func =
    let rec checksum_rec spreadsheet acc =
        match spreadsheet with
        | [] -> acc
        | hd::tl -> checksum_rec tl (acc + (row_func hd))
    in checksum_rec spreadsheet 0

let checksum_1 spreadsheet = checksum spreadsheet row_diff
let checksum_2 spreadsheet = checksum spreadsheet row_div
