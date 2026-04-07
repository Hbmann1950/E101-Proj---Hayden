state= "idle";
vy = 0;
gravity_val = 0.4;

start_x = x;
start_y = y;
ground_y = room_height * 0.85;

max_drag_dist = 100;
launch_power = 0.20;

scored_board = false;
scored_hole = false;
has_scored = false;
launch_power_actual = 0;

if global.twoplayer {
    sprite_index = spr_bag_blue;
} else {
    sprite_index = spr_bag_red;
}