extends StaticBody3D

@export var hint: String
@export var number: int

@export var door: Door

func _ready() -> void:
	door.door_number = number
	door.set_door_number(number) 
