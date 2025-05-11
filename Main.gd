extends Node2D
class_name Main

var _CommandScene = preload("res://scenes/Command.tscn")
var _commands: Array[Command]
var _selector: CommandSelector
var _is_selector_active: bool = false

var _trailing_joint: Joint
var _is_trailing_joint: bool

func _init() -> void:
	var _commands: Array[Joint] = []

func _ready() -> void:
	CE.new_connection.connect(_handle_new_connection)

func _process(delta: float) -> void:
	_handle_item_menu()

func _handle_new_connection():
	print("con")
	print(CE.contact_, " ", CE.new_contact, " ", CE)
	if CE.new_contact:
		if not _is_trailing_joint:
			_trailing_joint = Joint.new()
			add_child(_trailing_joint)
			_is_trailing_joint = true
			if CE.contact_.is_input():
				_trailing_joint.add_input(CE.contact_)
			else:
				_trailing_joint.add_output(CE.contact_)
		else:
			if CE.contact_.is_input():
				_trailing_joint.add_input(CE.contact_, false)
			else:
				_trailing_joint.add_output(CE.contact_, false)
			_is_trailing_joint = false
			CE.close_connection()

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
	var _new_command: Command = _CommandScene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	_new_command.configure(command_func_kind)
	_new_command.global_position = get_global_mouse_position() - Vector2(50, 50)
	
	_commands.append(_new_command)
	add_child(_new_command)

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
