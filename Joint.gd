extends Line2D
class_name Joint

var input: Contact
var output: Contact
var is_input_trailing: bool = false
var is_output_trailing: bool = false

func add_input(input_contact: Contact, no_output: bool = true):
	if no_output == true:
		print("set output no")
		add_point(input_contact.global_position, 0)
		add_point(get_global_mouse_position(), 1)
		input = input_contact
		is_output_trailing = true
	else:
		print("set output")
		set_point_position(1, input_contact.global_position)
		input = input_contact
		is_output_trailing = false
		is_input_trailing = false
	

func add_output(output_contact: Contact, no_input: bool = true):
	if no_input:
		add_point(output_contact.global_position, 1)
		add_point(get_global_mouse_position(), 0)
		output = output_contact
		is_input_trailing = true
	else:
		set_point_position(0, output_contact.global_position)
		output = output_contact
		is_input_trailing = false
		is_output_trailing = false

func _init() -> void:
	joint_mode = Line2D.LINE_JOINT_ROUND
	end_cap_mode = Line2D.LINE_CAP_ROUND
	width = 4

func _process(delta: float) -> void:
	if input and output:
		set_point_position(1, output.global_position)
		set_point_position(0, input.global_position)
	else:	
		if is_input_trailing:
			set_point_position(0, get_global_mouse_position())
		if is_output_trailing:
			set_point_position(1, get_global_mouse_position())
