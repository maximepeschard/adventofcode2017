#use "../common/test.ml"
#use "hash.ml"

let () =
  let size = 256
  and block_size = 16
  and rounds = 64
  and suffix = [17; 31; 73; 47; 23] in
  let tests = [
    (hash_1 5 "3,4,1,5") = 12;
    (hash_2 size block_size rounds suffix "") = "a2582a3a0e66e6e86e3812dcb672a272";
    (hash_2 size block_size rounds suffix "AoC 2017") = "33efeb34ea91902bb2f59c9920caa6cd";
    (hash_2 size block_size rounds suffix "1,2,3") = "3efbe78a8d82f29979031a4aa0b16a9d";
    (hash_2 size block_size rounds suffix "1,2,4") = "63960835bcdc130f0b66d7ff4f6a5a8e"
  ] in
  test_suite tests
