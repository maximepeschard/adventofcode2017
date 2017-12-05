(* Count the number of steps needed to exit a maze.
 * Each accessed offset instruction is modified by change_func *)
let exit_steps maze change_func =
  let maze_array = Array.of_list maze in
  let size = Array.length maze_array in
  let rec jump pos steps =
    if pos < 0 || pos >= size then steps
    else
      let new_pos = pos + maze_array.(pos) in
      let () = maze_array.(pos) <- change_func maze_array.(pos) in
      jump new_pos (steps + 1)
  in jump 0 0

let exit_steps_1 maze = exit_steps maze (fun x -> x + 1)
let exit_steps_2 maze = exit_steps maze (fun x -> if x >= 3 then x - 1 else x + 1)
