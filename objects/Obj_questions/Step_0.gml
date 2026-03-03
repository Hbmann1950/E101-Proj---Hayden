if (global.show_box == true) {

// makes the variable for scrolling increase
scroll_offset += 0.5; 

// checks for what the user has typed every frame
user_text = keyboard_string;

// checks every frame to make sure there isn't too much text typed
if (string_length(user_text) > 30) {
    keyboard_string = string_copy(user_text, 1, 30);
    user_text = keyboard_string;
}
}