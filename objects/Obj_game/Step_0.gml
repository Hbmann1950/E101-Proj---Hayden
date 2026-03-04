if game_over exit;

var _bag = instance_find(Obj_bag, 0);

if instance_exists(_bag) and global.bag_active {
    if _bag.state == "landed" {
        global.bag_active = false;
		
        if _bag.scored_hole {
            score_player += 3;
            show_debug_message("HOLE! Score: " + string(score_player));
        } else if _bag.scored_board {
            score_player += 1;
            show_debug_message("BOARD! Score: " + string(score_player));
        } else {
            show_debug_message("MISSED. Score: " + string(score_player));
		}

        if score_player >= 21 {
            game_over = true;
        } else {
            alarm[0] = 90;
        }
    }
}