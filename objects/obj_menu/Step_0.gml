// Get Mouse Position relative to the GUI layer
var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _w = display_get_gui_width();
var _h = display_get_gui_height();

// Define Sidebar start (right side)
var _side_x = _w - sidebar_width;
var _item_h = _h / menu_items;

// Reset index each frame; it will be set if the mouse is hovering
menu_index = -1;

for (var i = 0; i < menu_items; i++) {
    var _y1 = i * _item_h;
    var _y2 = _y1 + _item_h;
    
    // Check if mouse is within this button's box
    if (_mx > _side_x && _mx < _w && _my > _y1 && _my < _y2) {
        menu_index = i;
        
        // Check for Click
        if (mouse_check_button_pressed(mb_left)) {
            switch(i) {
                case 0: global.twoplayermode = false; room_goto(rm_game); break;
                case 1: global.twoplayermode = true;  room_goto(rm_game); break;
                case 2: game_end(); break;
            }
        }
    }
}