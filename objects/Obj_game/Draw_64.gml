draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text(20, 20, "Score: " + string(score_player));

if game_over {
    draw_set_halign(fa_center);
    draw_set_color(c_yellow);
    draw_text(room_width / 2, room_height / 2 - 20, "YOU WIN!");
    draw_text(room_width / 2, room_height / 2 + 20, "Final Score: " + string(score_player));
}