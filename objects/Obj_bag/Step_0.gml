switch (state) {

    case "idle":
        if mouse_check_button_pressed(mb_left) {
            if point_distance(mouse_x, mouse_y, x, y) < 30 {
                state = "dragging";
            }
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
                var spd = pull_x * launch_power;
                vx = spd;
                vy = -pull_y * launch_power * 1.2;
                state = "flying";
                global.bag_active = true;
            }
        }
    break;

    case "flying":
        vy += gravity_val;
        x += vx;
        y += vy;

        if instance_exists(Obj_board) {
            if x > Obj_board.bbox_left and x < Obj_board.bbox_right {
                if y >= Obj_board.bbox_top and vy > 0 {
                    y = Obj_board.bbox_top;
                    if !has_scored {
                        if instance_exists(Obj_hole) {
                            if point_distance(x, y, Obj_hole.x, Obj_hole.y) < 30 {
                                scored_hole = true;
                                has_scored = true;
                            }
                        }
                        if !has_scored {
                            scored_board = true;
                            has_scored = true;
                        }
                    }
                    state = "landed";
                }
            }
        }

        if state != "landed" and y >= ground_y {
            y = ground_y;
            state = "landed";
        }

        if state != "landed" and (x > room_width + 100 or x < -100) {
            state = "landed";
        }
    break;

    case "landed":
    break;
}