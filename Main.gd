extends Node2D
class_name Main

var _commands: Array[Joint]

func _init() -> void:
	var _commands: Array[Joint] = []

func _create_command():
	var _new_command = Command.new()
	print(_new_command.command_object, _new_command)
	_new_command.command_object.global_position.x = get_global_mouse_position().x
	_new_command.command_object.global_position.y = get_global_mouse_position().y
	add_child(_new_command.command_object)
	_commands.append(_new_command)

func _input(event: InputEvent) -> void:
	print(get_global_mouse_position())
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		_create_command()
