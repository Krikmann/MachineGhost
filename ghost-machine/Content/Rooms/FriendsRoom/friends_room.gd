extends StaticBody3D
@export var door: SpecialDoor

func _ready() -> void: 
	Services.friend_door = door
