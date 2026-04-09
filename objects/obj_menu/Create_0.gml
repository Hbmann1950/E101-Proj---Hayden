global.twoplayermode = false; 
menu_title = "Cornhole";

menu[0] = "1 Player";
menu[1] = "2 Players";
menu[2] = "Quit";

menu_items = array_length(menu);
menu_index = -1; // -1 means no button is hovered

// Sidebar Settings
sidebar_width = 300; 
sprite_to_draw = spr_logo;