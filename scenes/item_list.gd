extends ItemList
class_name CommandSelector

func _init() -> void:
	add_item("2AND")
	add_item("2OR")
	add_item("NOT")
	add_item("VAR")
	add_item("OUT")
	size.x = 80
	size.y = 150
