// Get input (Returns 1 if pressed, 0 if not)
var _up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var _down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var _select = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

// Move the index based on input
// If down is pressed, this adds 1. If up is pressed, this subtracts 1.
menu_index += _down - _up;

// Wrap the menu index so it loops around the top and bottom
if (menu_index < 0) {
    menu_index = menu_items - 1;
}
if (menu_index >= menu_items) {
    menu_index = 0;
}

// Execute logic if an option is selected
if (_select) {
    switch(menu_index) {
        case 0: // 1 Player
            global.twoplayermode = false;
            room_goto(rm_game);
            break;
			
        case 1: // 2 Players
            global.twoplayermode = true;
            room_goto(rm_game);
            break;
			
        case 2: // Quit
            game_end();
            break;
    }
}