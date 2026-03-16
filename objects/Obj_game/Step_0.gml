// Step Event for bag controller

if game_over exit; // stop logic if game over

var _bag = instance_find(Obj_bag, 0);

if instance_exists(_bag) and global.bag_active {
    if _bag.state == "landed" {

        global.bag_active = false;

        // Update score based on where the bag landed
        if _bag.scored_hole {
            score_player += 3;
        } 
        else if _bag.scored_board {
            score_player += 1;
        }

        // Spawn quiz UI only if it doesn't exist already
        if not instance_exists(obj_quiz_ui) {
            var quiz_ui = instance_create_layer(0, 0, "Controllers", obj_quiz_ui);
			obj_quiz_ui.show_ui();
        }
		else{
			obj_quiz_ui.show_ui();
		}

        // Check game over
        if score_player >= 21 {
            game_over = true;
        } else {
            alarm[0] = 90; // respawn bag after delay
        }
    }
}