extends Sprite2D
class_name CommandObjectSceneManager

var CommandSceneClass = preload("res://scenes/command_object.tscn")

var command_name = 'NOT'
var inputs_scenes: Array[CommandObjectContactSceneManager]
var outputs_scenes: Array[CommandObjectContactSceneManager]

var _pos_x = position.x
var _pos_y = position.y
var _command_scene: Sprite2D
var _is_mouse_hovered = false

func get_scene() -> Sprite2D:
	return _command_scene

func get_input_scene(idx: int) -> CommandObjectContactSceneManager:
	return inputs_scenes[idx]

func get_output_scene(idx: int) -> CommandObjectContactSceneManager:
	return outputs_scenes[idx]

func set_global_pos(pos: Vector2):
	_command_scene.global_position = pos

func add_on_root_scene():
	root.add_child(_command_scene)

func _init(
	num_of_inputs: int,
	num_of_outputs: int,
	command_func: G.CommandFunc,
) -> void:
	_command_scene = CommandSceneClass.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)	

	for num in range(num_of_inputs):
		var contact_scene_manager = CommandObjectContactSceneManager.new(
			G.ContactKind.IN, -100, num*50
		)
		_command_scene.add_child(contact_scene_manager.get_scene())
		inputs_scenes.append(contact_scene_manager)
	
	for num in range(num_of_outputs):
		var contact_scene_manager = CommandObjectContactSceneManager.new(
			G.ContactKind.OUT, +100, num*50
		)
		inputs_scenes.append(contact_scene_manager)
	
	var _command_object_sprite: Sprite2D = _command_scene.get_child(0).owner
	_command_object_sprite.self_modulate = G.CommandColors[command_func]
	_command_object_sprite.region_rect.size.y = num_of_inputs * 50
	
	var _command_object_label: Label = _command_scene.get_child(0)
	_command_object_label.size = _command_scene.region_rect.size
	_command_object_label.text = G.CommandNames[command_func]

#func _input(event: InputEvent) -> void:
	#print("input")
	#var mouse_pos = get_global_mouse_position()
	##if Input.is_action_pressed("left_click"):
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#print("pressed")
		#if _is_mouse_hovered:
			#_pos_x = mouse_pos.x
			#_pos_y = mouse_pos.y
			#print(_pos_x, " ", _pos_y)
			#_upd_pos()

#func _upd_pos():
	#_command_scene.global_position = Vector2(_pos_x, _pos_y)

func _is_mouse_over_object():
	_is_mouse_hovered = true
	print("mouse entered")

func _unset_is_mouse_over_object():
	_is_mouse_hovered = false
	print("mouse exited")
