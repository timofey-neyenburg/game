extends Node2D
class_name Command

enum CommandFunc {AND = 0, OR = 1, NOT = 2}

var _CommandObject = preload("res://scenes/command_object.tscn")
var _CommandObjectInput = preload("res://scenes/command_object_input.tscn")

var _num_of_inputs: int
var _num_of_outputs: int

var command_object: Node

func _init(
	num_of_inputs: int = 2,
	num_of_outputs: int = 1,
	command_func: CommandFunc = CommandFunc.OR,
) -> void:
	_num_of_inputs = num_of_inputs
	_num_of_outputs = num_of_outputs
	global_position = get_global_mouse_position()
	
	command_object = _CommandObject.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	
	var _command_obejct_sprite = command_object.get_child(0).owner
	
	for i in range(num_of_inputs):
		var _input: Sprite2D = _CommandObjectInput.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
		print("INPUT: ", _input)
		_input.position.x -= 100
		_input.position.y += i*50
		print(_input.position)
		_command_obejct_sprite.add_child(_input)
