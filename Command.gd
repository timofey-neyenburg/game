extends Node2D
class_name Command

var command_scene_manager: CommandObjectSceneManager
var inputs: Array[Contact]
var outputs: Array[Contact]

var _Func: Callable

func get_command_global_pos() -> Vector2:
	return command_scene_manager.get_scene().global_position

func get_scene() -> Sprite2D:
	return command_scene_manager.get_scene()

func set_scene_g_pos(pos: Vector2):
	command_scene_manager.set_global_pos(pos)

func add_on_root_scene():
	command_scene_manager.add_on_root_scene()

func _init(
	command_func: G.CommandFunc,
	num_of_inputs: int = 1,
	num_of_outputs: int = 1,
) -> void:
	command_scene_manager = CommandObjectSceneManager.new(
		num_of_inputs, num_of_outputs, command_func
	)
	_set_func(command_func)
	_set_inputs(num_of_inputs)
	_set_inputs(num_of_outputs)

func _set_inputs(num_of_inputs: int):
	for idx in range(num_of_inputs):
		var new_contact = Contact.new(G.ContactKind.IN)
		inputs.append(new_contact)

func _set_outputs(num_of_outputs: int):
	for idx in range(num_of_outputs):
		var new_contact = Contact.new(G.ContactKind.OUT)
		outputs.append(new_contact)

func _set_func(func_kind: G.CommandFunc):
	match func_kind:
		G.CommandFunc.AND2:
			_Func = _and
		G.CommandFunc.OR2:
			_Func = _or
		G.CommandFunc.NOT:
			_Func = _not
		G.CommandFunc.VAR:
			_Func = _var
		G.CommandFunc.OUT:
			_Func = _out
		
func _and(a: Array[bool]):
	var res = true
	for el in a:
		res = res and el
	return res

func _not(a: bool):
	return not(a)

func _or(a: Array[bool]):
	var res = false
	for el in a:
		res = res or el
	return res

func _var(value: bool):
	return value

func _out(value: bool):
	return value
