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
	if found_door_hints.size() == 5: open_correct_room()

func open_correct_room() -> void:
	Services.friend_door.can_interact = true
	# TODO Play something happened sound

func correct_room_found() -> void: 
	found_door_hints.clear()
	clear_door_hints.emit()
