extends Node
class_name Contact

var _kind: G.ContactKind
var _index: int

func _init(kind: G.ContactKind) -> void:
	_kind = kind
