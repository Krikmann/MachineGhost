@tool 
class_name LiftButton extends StaticBody3D

@export_tool_button("Press") var press_button_action = interact
 
signal button_pressed(floor) 
 
@export var to_floor: int
@export var button: MeshInstance3D
@export var press_cooldown: float 
 
var last_press_time: float 

func interact() -> void:
	if Time.get_ticks_msec() - last_press_time < press_cooldown: return
	 
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	 
	var starting_z = position.z
	tween.tween_property(button, "position:z", -0.1, 0.4) 
	tween.tween_property(button, "position:z", starting_z, 0.4) 
	
	button_pressed.emit(to_floor)
