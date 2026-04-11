switch(state) {

    case "idle":
        if mouse_check_button_pressed(mb_left) && point_distance(mouse_x, mouse_y, x, y) < 30 {
            state = "dragging";
        }
    break;

    case "dragging":
        var pull_x = clamp(start_x - mouse_x, 0, max_drag_dist);
        var pull_y = clamp(mouse_y - start_y, 0, max_drag_dist);
        launch_power_actual = pull_x;

        x = start_x;
        y = start_y;

        if mouse_check_button_released(mb_left) {
            if pull_x < 5 {
                state = "idle";
            } else {
                vx = pull_x * launch_power;
                vy = -pull_y * launch_power * 1.2;
                state = "flying";
				audio_play_sound(Sound_bagthrow,6,false);
                global.bag_active = true;
            }
        }
    break;

    case "flying":
	    vy += gravity_val;
	    x += vx;
	    y += vy;
	    image_angle += abs(vy);

	    // Hole detection
	    if instance_exists(Obj_hole) && point_distance(x, y, Obj_hole.x, Obj_hole.y) < 25 {
	        y = Obj_hole.y;
	        state = "landed";
	        if !has_scored {
				audio_play_sound(Sound_bagland,5,false);
	            scored_hole = true;
	            has_scored = true;
	        }
	    }
	    // Board slanted line collision
	    else if instance_exists(Obj_board) {
	        var x1 = 1030;
	        var y1 = 670;
	        var x2 = 1245;
	        var y2 = 605;

	        if x >= x1 && x <= x2 {
	            var m = (y2 - y1) / (x2 - x1);
	            var b = y1 - m * x1;
	            var y_on_line = m * x + b;

	            if y >= y_on_line && vy > 0 {
	                y = y_on_line;
	                state = "landed";
	                if !has_scored {
						audio_play_sound(Sound_bagland,5,false);
	                    scored_board = true;
	                    has_scored = true;
	                }
	            }
	        }
	    }

	    // Ground check
	    if state != "landed" && y >= ground_y {
	        y = ground_y;
			audio_play_sound(Sound_bagland,5,false);
	        state = "landed";
	    }

	    // Out of bounds
	    if state != "landed" && (x < -100 || x > room_width + 100) {
			audio_play_sound(Sound_bagland,5,false);
	        state = "landed";
	    }
	break;

    case "landed":
		
        if global.twoplayermode {
            global.twoplayer = !global.twoplayer;
        }
    break;
}