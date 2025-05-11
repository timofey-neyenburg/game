extends Node
class_name ConnectionEmmiter

signal new_connection

var new_contact: bool = false
var contact_: Contact

func emit_(contact: Contact):
	print("emit")
	contact_ = contact
	new_contact = true
	print("emit args: ", contact, " ", new_contact)
	new_connection.emit()

func close_connection():
	new_contact = false
