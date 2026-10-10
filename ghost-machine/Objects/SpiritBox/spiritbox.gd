class_name Spiritbox extends StaticBody3D

@onready var collision_shape := $CollisionShape3D
@onready var audio_player = $AudioStreamPlayer

func interact() -> void:
	collision_shape.disabled = true
	position = Vector3.ZERO
	rotation = Vector3.ZERO

	position = Vector3(0.7,-0.5,-1)
	rotation_degrees = Vector3(0, 90, 0)
 
	reparent(Services.player.hand_slot, false)

func speech():
	audio_player.play()
