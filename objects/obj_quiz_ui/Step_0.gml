// --- 1. FEEDBACK TIMER (always runs, no conditions) ---
if (showing_feedback)
{
    feedback_timer--;

    if (feedback_timer <= 0)
    {
        showing_feedback = false;

        if (current_ui_answers[selected_answer] == correct_answer)
        {	
            visible_ui = false;
        }
        else
        {
            generate_random_question();
        }

        selected_answer = -1;
    }

    return; // IMPORTANT: stop here, no input during feedback
}


// --- 2. INPUT (only when NOT showing feedback) ---
if (visible_ui && mouse_check_button_pressed(mb_left))
{
    var mx = device_mouse_x_to_gui(0);
    var my = device_mouse_y_to_gui(0);

    var w = display_get_gui_width();
    var h = display_get_gui_height();

    var qh = h * 0.4;
    var ah = h - qh;
    var answer_row_h = ah / 2;
    var answer_col_w = w / 2;

    var answer = -1;

    if (my > qh)
    {
        var row = (my - qh) div answer_row_h;
        var col = mx div answer_col_w;
        answer = row * 2 + col;
    }

    if (answer != -1)
    {
        process_answer(answer);
    }
}