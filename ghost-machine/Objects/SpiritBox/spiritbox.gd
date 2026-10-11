class_name Spiritbox extends StaticBody3D

@onready var collision_shape := $CollisionShape3D
@onready var audio_player = $AudioStreamPlayer
 
func interact() -> void:
	add_to_hand() 
	 
	if Services.global_audio.playing: await Services.global_audio.finished 
	change_to_main() 

func change_to_main():
	GameState.load_dorm()
	 
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("skip"):
		change_to_main() 

func add_to_hand() -> void:
	collision_shape.disabled = true
	position = Vector3.ZERO
	rotation = Vector3.ZERO

	position = Vector3(0.7,-0.5,-1)
	rotation_degrees = Vector3(0, 90, 0)
 
	reparent(Services.player.hand_slot, false)

func speech():
	GameState.play_hint()
