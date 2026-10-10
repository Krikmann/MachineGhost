@tool 
class_name LiftDoor extends StaticBody3D
 
@export var collision: CollisionShape3D
@export var visual: Node3D

func open() -> void:
	collision.disabled = true 
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(visual, "scale:z", 0.01, 2.0)

func close() -> void:
	collision.disabled = false 
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(visual, "scale:z", 1.0, 2.0)
