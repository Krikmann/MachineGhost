extends RigidBody3D
class_name Pickup

@export var item_name: String = "Item"
@export var item_mesh: Mesh

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

func _ready() -> void:
	if item_mesh:
		mesh_instance.mesh = item_mesh

func interact() -> void:
	collision_shape.disabled = true
	freeze = true
	position = Vector3.ZERO
	rotation = Vector3.ZERO

	position = Vector3(0.7,-0.5,-1)
	rotation_degrees = Vector3(0, 90, 0)
 
	reparent(Services.player.hand_slot, false)
