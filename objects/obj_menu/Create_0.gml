// Initialize the player count global variable
global.twoplayermode = false; 

menu_title = "Cornhole Calculations";

// Define the menu options
menu[0] = "1 Player";
menu[1] = "2 Players";
menu[2] = "Quit";

// Track which option is currently selected (0 = first option)
menu_index = 0;

// Count total items dynamically so you can easily add more later
menu_items = array_length(menu);