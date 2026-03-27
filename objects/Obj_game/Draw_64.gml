draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_left);

if global.twoplayermode {
	draw_set_color(c_red);
	draw_text(20, 20, "Player 1 Score: " + string(score_player));
	draw_set_color(c_blue);
	draw_text(20, 40, "Player 2 Score: " + string(score_player2));
	draw_set_color(c_white);
	if global.twoplayer {
		draw_text(20, 60, "Player 2 Is Tossing");
	}
	else {
		draw_text(20, 60, "Player 1 Is Tossing");
	}
}
else {
draw_text(20, 20, "Score: " + string(score_player));
}


if (game_over && !global.twoplayermode) {
    draw_set_halign(fa_center);
    draw_set_color(c_yellow);
    draw_text(room_width / 2, room_height / 2 - 20, "YOU WIN!");
    draw_text(room_width / 2, room_height / 2 + 20, "Final Score: " + string(score_player));
}
else if (game_over && global.twoplayermode) {
	draw_set_halign(fa_center); // used when two player mode is active, player with greater score wins when game ends
    draw_set_color(c_yellow);
    if (score_player >= score_player2) {
	draw_text(room_width / 2, room_height / 2 - 20, "PLAYER 1 WINS!");
	draw_text(room_width / 2, room_height / 2 + 20, "Final Score: " + string(score_player));
	}
	else {
	draw_text(room_width / 2, room_height / 2 - 20, "PLAYER 2 WINS!");
	draw_text(room_width / 2, room_height / 2 + 20, "Final Score: " + string(score_player2));
	}
}