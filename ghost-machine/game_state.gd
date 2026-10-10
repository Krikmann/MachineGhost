extends Node

signal door_hint_added(hint_text: String)
signal clear_door_hints() 

var found_door_hints: Array[String] = []

func add_door_hint(hint: String) -> void:
	print("adding hint", hint) 
	if hint in found_door_hints: 
		print("RETURNING") 
		return
	found_door_hints.append(hint)
	door_hint_added.emit(hint)

func correct_room_found() -> void: 
	found_door_hints.clear()
	clear_door_hints.emit()
