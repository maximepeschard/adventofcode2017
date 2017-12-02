let row_diff row =
    let rec row_diff_rec smallest largest row =
        match row with
        | [] -> largest - smallest
        | hd::tl -> row_diff_rec (min smallest hd) (max largest hd) tl
    in row_diff_rec max_int min_int row

let checksum spreadsheet =
    let rec checksum_rec spreadsheet acc =
        match spreadsheet with
        | [] -> acc
        | hd::tl -> checksum_rec tl (acc + (row_diff hd))
    in checksum_rec spreadsheet 0
