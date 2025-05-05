extends Camera2D

var _mouse_pos: Vector2
var start_camera_move: bool = false
var scale_delta: float = 0.05
var camera_start_pos: Vector2


func _init() -> void:
	camera_start_pos = global_position

func _process(delta: float) -> void:
	_mouse_pos = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	var bg_img: Sprite2D = get_tree().root.get_child(0).get_node("background")
	var bg_img_scale = bg_img.get("global_scale")

	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN):
		if zoom.x > 0.5:
			zoom.x -= scale_delta
			zoom.y -= scale_delta
			bg_img_scale.x += scale_delta*5
			bg_img_scale.y += scale_delta*5
			bg_img.set("global_scale", bg_img_scale)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP):
		if zoom.x < 1.1:
			zoom.x += scale_delta
			zoom.y += scale_delta
			bg_img_scale.x -= scale_delta*5
			bg_img_scale.y -= scale_delta*5
			bg_img.set("global_scale", bg_img_scale)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		var current_mouse_pos = get_global_mouse_position()
		var viewport_size = get_viewport_rect().size
		var diff = _mouse_pos - current_mouse_pos

		if not start_camera_move:
			global_position += diff
		else:
			start_camera_move = true
			_mouse_pos = current_mouse_pos
		
		var camera_pos_diff = camera_start_pos - global_position
		#camera_pos_diff.x -= viewport_size.x
		#camera_pos_diff.y += viewport_size.y
		
		print(viewport_size)
		print("POS DIFF: ", camera_pos_diff)
		
		bg_img.region_rect.size.x = viewport_size.x + abs(camera_pos_diff.x)
		bg_img.region_rect.size.y = viewport_size.y + abs(camera_pos_diff.y)
		#bg_img.region_rect.size += diff
		print("BG_IMG REGION: ", bg_img.region_rect.size)
		#print("ZOOM: ", zoom)
			
	start_camera_move = false
