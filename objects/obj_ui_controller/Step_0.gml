var _ui_layer = layer_get_id("UILayer_1");
if (_ui_layer != -1 && layer_get_visible(_ui_layer)) {
    if (mouse_check_button_pressed(mb_left)) {
        check_ui_click();
    }
}
