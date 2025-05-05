class_name CommandObject
extends Sprite2D

@export
var command_name = 'NOT'

var scene_obj = preload("res://scenes/command_object.tscn")
var _pos_x = position.x
var _pos_y = position.y
var _is_mouse_hovered = false

func _ready() -> void:
	var collision_object = get_node("command object area")
	print(collision_object)
	print(_pos_x, _pos_y)
	#collision_object.mouse_entered.connect(_is_mouse_over_object)

func _input(event: InputEvent) -> void:
	var mouse_pos = get_global_mouse_position()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		if _is_mouse_hovered:
			var _new_scene = scene_obj.instantiate()
			#var _new_scene = Command.new()
			var root_node = get_tree().root.get_child(0)
			print(root_node)
			root_node.add_child(_new_scene)
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		print("mouse pressed")

		if _is_mouse_hovered:
			_pos_x = mouse_pos.x
			_pos_y = mouse_pos.y
			print(_pos_x, " ", _pos_y)
			_upd_pos()

func _upd_pos():
	position = Vector2(_pos_x, _pos_y)

func _is_mouse_over_object():
	_is_mouse_hovered = true
	print("mouse entered")
	print(_is_mouse_hovered)

func _unset_is_mouse_over_object():
	_is_mouse_hovered = false
	print("mouse exited")
	print(_is_mouse_hovered)
