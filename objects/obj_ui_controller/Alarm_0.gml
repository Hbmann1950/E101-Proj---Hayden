/// Alarm[0]
var _root_fp = layer_get_flexpanel_node("UILayer_1");
if (_root_fp != -1) {
    var _root_node = find_ui_node(_root_fp, "root");
    if (_root_node != undefined) {
        generate_random_question();
    }
}