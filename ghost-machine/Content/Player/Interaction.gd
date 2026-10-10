extends RayCast3D


@onready var prompt
var collider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if is_colliding():
		collider = get_collider()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if collider and collider.has_method("interact"):	
			collider.interact(owner)
