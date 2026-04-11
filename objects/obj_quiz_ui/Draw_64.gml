if (!visible_ui) exit;

// Full background
draw_set_color(c_gray);
draw_rectangle(0,0,display_get_gui_width(), display_get_gui_height(), false);

// Layout
var w = display_get_gui_width();
var h = display_get_gui_height();
var qh = h * 0.4;
var ah = h - qh;
var aw = w / 2;

// Question container
draw_set_color(c_black);
draw_rectangle(0,0,w,qh,false);

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(w/2, qh/2, question_text);

// Border
draw_set_color(c_black);
draw_rectangle(0,0,w,qh,true);

// === ANSWER BOXES ===
for (var i = 0; i < 4; i++)
{
    var x1, y1, x2, y2;

    // Positioning
    if (i == 0) { x1 = 0;   y1 = qh;         x2 = aw; y2 = qh + ah/2; }
    if (i == 1) { x1 = aw;  y1 = qh;         x2 = w;  y2 = qh + ah/2; }
    if (i == 2) { x1 = 0;   y1 = qh + ah/2;  x2 = aw; y2 = h; }
    if (i == 3) { x1 = aw;  y1 = qh + ah/2;  x2 = w;  y2 = h; }

    // === COLOR LOGIC ===
    var col = c_gray;

    if (showing_feedback)
    {
        // Highlight correct answer
        if (current_ui_answers[i] == correct_answer)
        {
            col = c_green;
        }

        // Highlight selected answer
        if (i == selected_answer)
        {
            if (current_ui_answers[i] == correct_answer)
            {
                col = c_green;
            }
            else
            {
                col = c_red;
            }
        }
    }

    // Draw box
    draw_set_color(col);
    draw_rectangle(x1, y1, x2, y2, false);

    // Border
    draw_set_color(c_black);
    draw_rectangle(x1, y1, x2, y2, true);
}

// === ANSWER TEXT ===
draw_set_color(c_white);

for (var i=0; i<4; i++)
{
    var dx, dy;

    if (i==0) { dx=aw/2; dy=qh + ah/4; }
    if (i==1) { dx=aw + aw/2; dy=qh + ah/4; }
    if (i==2) { dx=aw/2; dy=qh + 3*ah/4; }
    if (i==3) { dx=aw + aw/2; dy=qh + 3*ah/4; }

    var ans_val = current_ui_answers[i];

    // Format arrays nicely
    if is_array(ans_val)
    {
        var s = "";
        for (var j=0; j<array_length(ans_val); j++)
        {
            if is_array(ans_val[j])
            {
                s += "(" + string_join(ans_val[j], ",") + ")";
            }
            else
            {
                s += string(ans_val[j]);
            }

            if j < array_length(ans_val)-1 s += ", ";
        }
        ans_val = s;
    }

    draw_text(dx, dy, ans_val);
}