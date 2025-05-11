extends Sprite2D
class_name Command

var inputs: Array[Contact]
var outputs: Array[Contact]
var command_name: String
var _uid: int
var _ContactScene = preload("res://scenes/Contact.tscn")
var _Func: Callable
var _is_mouse_hovered: bool = false


func configure(command_func: G.CommandFunc):
	var num_of_io = _get_num_of_inputs_and_outputs(command_func)
	_set_func(command_func)
	_set_ui(command_func, num_of_io.x, num_of_io.y)
	_set_uid()

func _get_num_of_inputs_and_outputs(command_func: G.CommandFunc) -> Vector2:
	match command_func:
		G.CommandFunc.AND2:
			return Vector2(2, 1)
		G.CommandFunc.OR2:
			return Vector2(2, 1)
		G.CommandFunc.NOT:
			return Vector2(1, 1)
		G.CommandFunc.VAR:
			return Vector2(0, 1)
		G.CommandFunc.OUT:
			return Vector2(1, 0)
	return Vector2(1, 1)

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

func _set_uid():
	G.IDref += 1
	_uid = G.IDref
	
func _set_ui(command_func: G.CommandFunc, num_of_inputs: int, num_of_outputs: int):
	for num in range(num_of_inputs):
		var input_contact: Contact = _ContactScene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)

		input_contact.configure(G.ContactKind.IN)
		input_contact.set_relative_pos(-100, num*50)
		
		add_child(input_contact)
		inputs.append(input_contact)
		
	for num in range(num_of_outputs):
		var output_contact: Contact = _ContactScene.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)

		output_contact.configure(G.ContactKind.OUT)
		output_contact.set_relative_pos(+100, num*50)
		
		add_child(output_contact)
		outputs.append(output_contact)
	
	self_modulate = G.CommandColors[command_func]
	region_rect.size.y = num_of_inputs * 50
	
	var _command_object_label: Label = get_child(0)
	_command_object_label.size = region_rect.size
	_command_object_label.text = G.CommandNames[command_func]
		
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

func set_mouse_hover():
	_is_mouse_hovered = true

func unset_mouse_hover():
	_is_mouse_hovered = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("left_click"):
		if _is_mouse_hovered:
			print("hovered")
			if G.CurrentHoveredCommand == -1 or G.CurrentHoveredCommand == _uid:
				global_position = get_global_mouse_position()
				if G.CurrentHoveredCommand == -1:
					G.CurrentHoveredCommand = _uid
	if Input.is_action_just_released("left_click"):
		if G.CurrentHoveredCommand == _uid:
			G.CurrentHoveredCommand = -1
