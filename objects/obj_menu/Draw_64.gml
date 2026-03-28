// Get exact GUI dimensions
var _w = display_get_gui_width();
var _h = display_get_gui_height();

// Draw full background (Deep Charcoal)
draw_set_color(#121212);
draw_rectangle(0, 0, _w, _h, false);

// Setup layout fractions
var _th = _h * 0.4;             // Top 40% for the title
var _mh = _h - _th;             // Bottom 60% for the options
var _item_h = _mh / menu_items; // Evenly divide the bottom 60%

// --- Draw Title Container ---
// Title Background (Dark Slate)
draw_set_color(#1E1E24);
draw_rectangle(0, 0, _w, _th, false);

// Title Border (Medium Gray)
draw_set_color(#333333);
draw_rectangle(0, 0, _w, _th, true); 

// Title Text (Pure White)
draw_set_color(#FFFFFF);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_title); 

// Draw the placeholder variable here!
draw_text(_w / 2, _th / 2, menu_title);

draw_set_font(fnt_ui); 
// --- Draw Menu Options ---
for (var i = 0; i < menu_items; i++) {
    
    var _row_y1 = _th + (i * _item_h);
    var _row_y2 = _row_y1 + _item_h;
    var _center_y = _row_y1 + (_item_h / 2);

    // Draw background (Soft Blue if selected, Dark Slate if not)
    if (i == menu_index) {
        draw_set_color(#4A90E2);
    } else {
        draw_set_color(#1E1E24);
    }
    draw_rectangle(0, _row_y1, _w, _row_y2, false);

    // Draw border (Medium Gray)
    draw_set_color(#333333);
    draw_rectangle(0, _row_y1, _w, _row_y2, true);

    // Draw text (Pure White for selected, Light Gray for unselected)
    if (i == menu_index) {
        draw_set_color(#FFFFFF);
    } else {
        draw_set_color(#B3B3B3);
    }
    draw_text(_w / 2, _center_y, menu[i]);
}

// --- Cleanup ---
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);