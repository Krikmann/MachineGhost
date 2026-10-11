extends Node3D
 
@export var spiritbox: Spiritbox
 
func _ready() -> void:
	GameState.current_puzzle = 1
	while !spiritbox: await get_tree().physics_frame
	spiritbox.add_to_hand()
