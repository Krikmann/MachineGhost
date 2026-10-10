extends StaticBody3D

@onready var collision_shape := $CollisionShape3D

var _can_pickup := false
var _original_parent: Node = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pickup(slot: Node):
	_original_parent = get_parent()
	collision_shape.disabled = true   
	reparent(slot, true)  # true = keep global transform (no snap)

func drop():
	collision_shape.disabled = false
	reparent(_original_parent, true)
