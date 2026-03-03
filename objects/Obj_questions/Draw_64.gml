
if (global.show_box == true) {

//gets size of screen?
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// set size
var _box_width = 1200;
var _box_height = 500;

// gets coordinates in order to make rectangle appear at center
var _x1 = (_gui_w / 2) - (_box_width / 2);
var _y1 = (_gui_h / 2) - (_box_height / 2);
var _x2 = (_gui_w / 2) + (_box_width / 2);
var _y2 = (_gui_h / 2) + (_box_height / 2);

// thickness for border
var _thickness = 5; 

// draws border / larger rectangle
draw_set_color(c_black); 
draw_rectangle(_x1, _y1, _x2, _y2, false);

// code below is used for drawing the sprite background in the gui
// add thickness to x1/y1 and subtract it from x2/y2 to pull edges in
var _tx = _x1 + _thickness;
var _ty = _y1 + _thickness;
var _tw = (_x2 - _x1) - (_thickness * 2);
var _th = (_y2 - _y1) - (_thickness * 2);


// makes sprites drawn only be visible within a given boundary (used to contain sprite within box)
gpu_set_scissor(_tx, _ty, _tw, _th);

// makes the tiled sprite move within the box
var _background_color = c_aqua;
draw_sprite_tiled_ext(spr_textbox_background, 0, _tx + scroll_offset, _ty + scroll_offset, 1, 1, _background_color, 1);

// remove scissor
gpu_set_scissor(0, 0, display_get_gui_width(), display_get_gui_height());

// draws the text
draw_set_color(c_black); 
draw_set_halign(fa_center); // centers horizontally
draw_set_valign(fa_middle); // centers vertically

// gets center of box
var _center_x = (_x1 + _x2) / 2;
var _center_y = (_y1 + _y2) / 2;

// draw the user's text
draw_text(_center_x, _center_y, user_text);

// reset color again
draw_set_color(c_white);

// also resets 
draw_set_halign(fa_left);
draw_set_valign(fa_top);

};