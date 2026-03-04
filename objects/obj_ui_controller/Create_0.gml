/// --- obj_ui_controller Create Event ---

// Game variables
game_over = false;
score_player = 0;
correct_answer = 0;
current_ui_answers = [0, 0, 0, 0];

// Hide the UI Layer at start
var _ui_layer_id = layer_get_id("UILayer_1");
if (_ui_layer_id != -1) {
    layer_set_visible(_ui_layer_id, false);
}

// Question templates
questions = [
    { q_text: "What is {0} + {1}?", ans: function(a,b) { return a + b; }, range: [1,10] },
    { q_text: "What is {0} - {1}?", ans: function(a,b) { return a - b; }, range: [5,20] }
];


/// --- Recursive Flex Panel node search ---
function find_ui_node(_parent, _name) {
    if (_parent == -1 || _parent == undefined) return undefined;
    if (flexpanel_node_get_name(_parent) == _name) return _parent;

    var _count = flexpanel_node_get_num_children(_parent);
    for (var i = 0; i < _count; i++) {
        var _child = flexpanel_node_get_child(_parent, i);
        var _result = find_ui_node(_child, _name);
        if (_result != undefined) return _result;
    }
    return undefined;
}


/// --- Generate a random question and update UI ---
function generate_random_question() {
    var _template = questions[irandom(array_length(questions) - 1)];
    var _num1 = irandom_range(_template.range[0], _template.range[1]);
    var _num2 = irandom_range(_template.range[0], _template.range[1]);

    var _final_q = string_replace(_template.q_text, "{0}", string(_num1));
    _final_q = string_replace(_final_q, "{1}", string(_num2));

    correct_answer = _template.ans(_num1, _num2);

    var _options = [correct_answer, correct_answer + 2, correct_answer - 2, correct_answer + 10];
    array_shuffle(_options);
    current_ui_answers = _options;

    // --- Get root Flex Panel inside UI Layer ---
    var _root = layer_get_flexpanel_node("UILayer_1");
    if (_root == -1) return; // no root FP

    var _root_node = find_ui_node(_root, "root");
    if (_root_node == undefined) return; // root not found

    // Update question text
    var _q_node = find_ui_node(_root_node, "q_text");
    if (_q_node != undefined) {
        _q_node.data.text = _final_q;
    }

    // Update answer texts
    var _answer_names = ["a1_text", "a2_text", "a3_text", "a4_text"];
    for (var i = 0; i < array_length(_answer_names); i++) {
        var _a_node = find_ui_node(_root_node, _answer_names[i]);
        if (_a_node != undefined) {
            _a_node.data.text = string(_options[i]);
        }
    }
}


function check_ui_click() {

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    var _root = layer_get_flexpanel_node("UILayer_1");
    if (_root == -1) return;

    // Make sure layout is calculated
    flexpanel_calculate_layout(_root, display_get_gui_width(), display_get_gui_height(), flexpanel_direction.LTR);

    var _answer_nodes = ["Answer_1", "Answer_2", "Answer_3", "Answer_4"];

    for (var i = 0; i < 4; i++) {

        var _node = find_ui_node(_root, _answer_nodes[i]);
        if (is_undefined(_node)) continue;

        // This returns the struct that *includes width + height*
        var _pos = flexpanel_node_layout_get_position(_node, false);

        var left   = _pos.left;
        var top    = _pos.top;
        var right  = left + _pos.width;
        var bottom = top  + _pos.height;

        if (_mx >= left && _mx <= right &&
            _my >= top  && _my <= bottom) {

            process_answer(i);
            return;
        }
    }
}


/// --- Show UI Layer and generate a new question ---
function show_ui_folder() {
    var _ui_layer_id = layer_get_id("UILayer_1");
    if (_ui_layer_id != -1) layer_set_visible(_ui_layer_id, true);
    generate_random_question();
}


/// --- Process selected answer ---
function process_answer(_index) {
    var _chosen_val = current_ui_answers[_index];
    if (_chosen_val == correct_answer) {
        score_player += 10;

        // Hide UI Layer
        var _ui_layer_id = layer_get_id("UILayer_1");
        if (_ui_layer_id != -1) layer_set_visible(_ui_layer_id, false);

        global.bag_active = true;
        show_debug_message("Correct! Score: " + string(score_player));
    } else {
        show_debug_message("Wrong answer! Generating new question...");
        generate_random_question();
    }
}