// Step Event for bag controller

if (keyboard_check_pressed(vk_escape)) // go to main manue if esc is pressed
{
	audio_play_sound(Sound_switchmenu,5,false);
    room_goto(rm_menu);
}

if game_over exit; // stop logic if game over

var _bag = instance_find(Obj_bag, 0);

if instance_exists(_bag) and global.bag_active {
    if _bag.state == "landed" {

        global.bag_active = false;

        // Update score based on where the bag landed
        if _bag.scored_hole {
			// if statements are to check for two player mode and which player threw bag
			if global.twoplayermode {
				if global.twoplayer {
					score_player2 += 3; // player 2 scored a hole 
				}
				else {
					score_player += 3; // player 1 scored a hole
				}
			}
			else {
				score_player += 3; // player scored a hole
			}
        } 
        else if _bag.scored_board {
			// if statements are to check for two player mode and which player threw bag
			if global.twoplayermode {
				if global.twoplayer {
					score_player2 += 1; // player 2 scored board
				}
				else {
					score_player += 1; // player 1 scored board
				}
			}
			else {
				score_player += 21; // player scored board
			}
        }

        // Check game over
        if (score_player >= 21) || (score_player2 >= 21) {
		    if (!game_over) { // prevents restarting the timer every step
		        game_over = true;
		        alarm[1] = 360; // start 6-second timer
		    }
		} else {
		    alarm[0] = 90; // respawn bag after delay
		}
    }
}