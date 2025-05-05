extends Sprite2D
class_name CommandObjectInput

var _mouse_over = false
var _lines: Array[Joint] = []

func _set_mouse_over():
	_mouse_over = true

func _unset_mouse_over():
	_mouse_over = false

func _input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if _mouse_over:
			var tree_root = get_tree().root.get_child(0)
			var new_line = Joint.new(global_position)
			print(global_position)
			print(new_line)
			tree_root.add_child(new_line)
			_lines.append(new_line)
			

func _process(delta: float) -> void:
	for line in _lines:
		line._update_pos(global_position, get_global_mouse_position())
