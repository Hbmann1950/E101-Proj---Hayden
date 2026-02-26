// Bag
draw_set_color(c_maroon);
draw_circle(x, y, 16, false);
draw_set_color(c_black);
draw_circle(x, y, 16, true);

if state == "dragging" {
    var pull_x = clamp(start_x - mouse_x, 0, max_drag_dist);
    var pull_y = clamp(mouse_y - start_y, 0, max_drag_dist);

    // Arrow showing aim direction
    var arrow_x = start_x + (pull_x / max_drag_dist) * 60;
    var arrow_y = start_y - (pull_y / max_drag_dist) * 60;
    draw_set_color(c_white);
    draw_arrow(start_x, start_y, arrow_x, arrow_y, 12);

    // Trajectory dots
    var spd = pull_x * launch_power;
    var pvx = spd;
    var pvy = -pull_y * launch_power * 1.2;
    var px = start_x;
    var py = start_y;

    draw_set_color(c_yellow);
    draw_set_alpha(0.6);

    // count total steps to peak
    var count_pvx = spd;
    var count_pvy = -pull_y * launch_power * 1.2;
    var total_steps = 0;
    for (var i = 0; i < 120; i++) {
        count_pvy += gravity_val;
        if count_pvy > 0 break;
        total_steps++;
    }
    var half_steps = floor(total_steps * (pull_x / max_drag_dist) * 0.5);

    // draw only up to half_steps
    for (var i = 0; i < half_steps; i++) {
        pvy += gravity_val;
        px += pvx;
        py += pvy;
        if py >= ground_y break;
        if i mod 3 == 0 {
            draw_circle(px, py, 3, false);
        }
    }
    draw_set_alpha(1);
}