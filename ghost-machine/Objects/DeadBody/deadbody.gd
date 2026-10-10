extends Node3D


@export var can_interact = true
@export var next_scene: PackedScene
@export var delay: float = 30.0

const Fire_Scene = preload("res://Objects/Fire/Fire.tscn")

var Spawned = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func interact() -> void:
	spawn_fire()
	
func spawn_fire() -> void:
	if Spawned: return
	Spawned = true
	var new_instance = Fire_Scene.instantiate() as Node3D
	add_child(new_instance)
	new_instance.position = Vector3(0.0, 0.1, 0.0)
	
	await get_tree().create_timer(delay).timeout
	start_end_scene()


func start_end_scene() -> void:
	if next_scene:
		get_tree().change_scene_to_packed(next_scene)
