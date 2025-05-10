extends Sprite2D
class_name CommandObjectContactSceneManager

var _mouse_over = false
var _lines: Array[Joint] = []
var _input_kind: G.ContactKind
var _object_scene_class: PackedScene = preload("res://scenes/command_object_input.tscn")
var _object_scene_instance: Sprite2D

func _init(kind: G.ContactKind, pos_delta_x: int, pos_delta_y: int) -> void:
	_input_kind = kind
	_object_scene_instance = _object_scene_class.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	_object_scene_instance.position.x += pos_delta_x # 100
	_object_scene_instance.position.y += pos_delta_y #i*50

func get_scene() -> Sprite2D:
	return _object_scene_instance

func _process(delta: float) -> void:
	for line in _lines:
		line._update_pos(global_position, get_global_mouse_position())

func _set_mouse_over():
	_mouse_over = true

func _unset_mouse_over():
	_mouse_over = false

#func _input(event: InputEvent) -> void:
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#if _mouse_over:
			#var tree_root = get_tree().root.get_child(0)
			##var new_line = Joint.new(global_position)
			##tree_root.add_child(new_line)
			##_lines.append(new_line)
