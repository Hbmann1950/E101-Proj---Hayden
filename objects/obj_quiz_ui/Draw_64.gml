if (!visible_ui) exit;

// Full background
draw_set_color(c_gray);
draw_rectangle(0,0,display_get_gui_width(), display_get_gui_height(), false);

// Split screen: top = question, bottom = answers
var w = display_get_gui_width();
var h = display_get_gui_height();
var qh = h * 0.4;         // question container height
var ah = h - qh;           // answer container height
var aw = w / 2;            // answer left/right width

// Question container
draw_set_color(c_gray);
draw_rectangle(0,0,w,qh,false);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(w/2, qh/2, question_text);
// Draw border
draw_set_color(c_black);
draw_rectangle(0,0,w,qh,true);

// Answer container top
draw_set_color(c_gray);
draw_rectangle(0,qh,aw,qh+ah/2,false);
draw_rectangle(aw,qh,w,qh+ah/2,false);
// Draw border
draw_set_color(c_black);
draw_rectangle(0,qh,aw,qh+ah/2,true);
draw_rectangle(aw,qh,w,qh+ah/2,true);

// Answer container bottom
draw_set_color(c_gray);
draw_rectangle(0,qh+ah/2,aw,h,false);
draw_rectangle(aw,qh+ah/2,w,h,false);
// Draw border
draw_set_color(c_black);
draw_rectangle(0,qh+ah/2,aw,h,true);
draw_rectangle(aw,qh+ah/2,w,h,true);

// Answer text
draw_set_color(c_white);
var answer_texts = current_ui_answers;

for (var i=0; i<4; i++) {
    var dx, dy;
    if i==0 { dx=aw/2; dy=qh + ah/4; }
    if i==1 { dx=aw + aw/2; dy=qh + ah/4; }
    if i==2 { dx=aw/2; dy=qh + 3*ah/4; }
    if i==3 { dx=aw + aw/2; dy=qh + 3*ah/4; }

    var ans_val = answer_texts[i];

    // Format arrays nicely
    if is_array(ans_val) {
        var s = "";
        for (var j=0; j<array_length(ans_val); j++) {
            if is_array(ans_val[j]) {
                s += "(" + string_join(ans_val[j], ",") + ")";
            } else {
                s += string(ans_val[j]);
            }
            if j < array_length(ans_val)-1 s += ", ";
        }
        ans_val = s;
    }

    draw_text(dx, dy, ans_val);
}