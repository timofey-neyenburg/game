extends Sprite2D
class_name Contact

var _kind: G.ContactKind
var _is_mouse_hovered: bool = false

func is_input():
	return _kind == G.ContactKind.IN
	
func is_output():
	return _kind == G.ContactKind.OUT

func configure(kind: G.ContactKind) -> void:
	_kind = kind
	
func set_relative_pos(delta_x: int, delta_y: int):
	position.x += delta_x
	position.y += delta_y

func set_mouse_hovered():
	_is_mouse_hovered = true

func unset_mouse_hovered():
	_is_mouse_hovered = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		if _is_mouse_hovered:
			CE.emit_(self)
