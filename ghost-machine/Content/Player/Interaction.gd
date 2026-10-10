class_name Interaciton extends RayCast3D


@onready var prompt
var collider


func _physics_process(delta: float) -> void:
	if is_colliding():
		collider = get_collider()
	else: collider = null


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if collider and collider.has_method("interact"):
			collider.interact()
