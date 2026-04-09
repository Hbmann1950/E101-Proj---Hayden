var _w = display_get_gui_width();
var _h = display_get_gui_height();
var _side_x = _w - sidebar_width;

// --- 1. Draw Sprite/Background Area (Left Side) ---
draw_set_color(#121212);
draw_rectangle(0, 0, _side_x, _h, false);

// Draw your decorative sprite in the center of the left area
if (sprite_exists(sprite_to_draw)) {
    draw_sprite_ext(sprite_to_draw, 0, _side_x / 2, _h / 2, 1, 1, 0, c_white, 1);
}

// --- 2. Draw Sidebar Buttons (Right Side) ---
var _item_h = _h / menu_items;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_ui);

for (var i = 0; i < menu_items; i++) {
    var _y1 = i * _item_h;
    var _y2 = _y1 + _item_h;
    var _center_y = _y1 + (_item_h / 2);

    // Button Background: Change color if hovered (menu_index)
    if (i == menu_index) {
        draw_set_color(#4A90E2); // Hover Blue
    } else {
        draw_set_color(#1E1E24); // Idle Dark
    }
    draw_rectangle(_side_x, _y1, _w, _y2, false);

    // Button Border
    draw_set_color(#333333);
    draw_rectangle(_side_x, _y1, _w, _y2, true);

    // Button Text
    draw_set_color(c_white);
    draw_text(_side_x + (sidebar_width / 2), _center_y, menu[i]);
}

// Reset drawing defaults
draw_set_halign(fa_left);
draw_set_valign(fa_top);