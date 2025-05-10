extends Node2D
class_name Main

var _commands: Array[Joint]
var _selector: CommandSelector
var _is_selector_active: bool = false

func _init() -> void:
	var _commands: Array[Joint] = []

func _process(delta: float) -> void:
	_handle_item_menu()

func _handle_item_menu():
	# Calls twice, fuck me
	if Input.is_action_just_pressed("add_command"):
		if _is_selector_active == false:
			_is_selector_active = true
			_selector = CommandSelector.new()
			_selector.global_position = get_global_mouse_position()
			root.add_child(_selector)
	if _is_selector_active == true:
		if _selector.is_anything_selected():
			_is_selector_active = false
			var selected_item: int = _selector.get_selected_items()[0]
			var item = _selector.get_item_text(selected_item)
			var _command_kind = _get_command_func_kind_by_string(item)
			root.remove_child(_selector)
			_create_command(_command_kind)

func _create_command(command_func_kind: G.CommandFunc):
	var _new_command = Command.new(command_func_kind)
	_commands.append(_new_command)
	_new_command.set_scene_g_pos(get_global_mouse_position() - Vector2(50, 50))
	_new_command.add_on_root_scene()
	
	print(_new_command.command_scene_manager.get_children())
	_new_command.command_scene_manager.get_child(1).connect(
		"mouse_entered",
		_new_command.command_scene_manager.get_scene(),
		"_is_mouse_over_object"
	)
	 #<emitting_node>.connect("signal_name", <target_node>, "target_method_name")

func _get_command_func_kind_by_string(command_func_name: String):
	match command_func_name:
		"2AND":
			return G.CommandFunc.AND2
		"2OR":
			return G.CommandFunc.OR2
		"NOT":
			return G.CommandFunc.NOT
		"VAR":
			return G.CommandFunc.VAR
		"OUT":
			return G.CommandFunc.OUT
