extends Line2D
class_name Joint

var input_command: Command


func _init(input_command: Command) -> void:
	var _left_pos = input_command.global_position
	var _right_pos = get_global_mouse_position()
	
	joint_mode = Line2D.LINE_JOINT_ROUND
	end_cap_mode = Line2D.LINE_CAP_BOX
	width = 5
	
	add_point(_left_pos, 0) 
	add_point(_right_pos, 1)

func _update_pos(_left_pos: Vector2, _right_pos: Vector2):
	_left_pos = _left_pos
	_right_pos = _right_pos
	set_point_position(0, _left_pos)
	set_point_position(1, _right_pos)
