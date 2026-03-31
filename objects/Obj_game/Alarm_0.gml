with (Obj_bag) { instance_destroy(); }
instance_create_layer(200, 580, "Instances_1", Obj_bag);
global.bag_active = false;
// Spawn quiz UI only if it doesn't exist already
if not instance_exists(obj_quiz_ui) {
    var quiz_ui = instance_create_layer(0, 0, "Controllers", obj_quiz_ui);
	obj_quiz_ui.show_ui();
}
else{
	obj_quiz_ui.show_ui();
}