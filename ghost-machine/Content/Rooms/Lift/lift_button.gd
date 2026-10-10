@tool 
class_name LiftButton extends StaticBody3D

@export_tool_button("Press") var press_button_action = interact
 
signal button_pressed(floor) 
 
@export var to_floor: int

func interact() -> void:
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	 
	var starting_z = position.z
	tween.tween_property(self, "position:z", -0.1, 0.4) 
	tween.tween_property(self, "position:z", starting_z, 0.4) 
	
	button_pressed.emit(to_floor)
