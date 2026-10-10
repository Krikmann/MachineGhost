@tool
extends StaticBody3D

@export var lift_door: StaticBody3D
@export var lift_door_2: StaticBody3D
@export var buttons: Node3D

@export var floor_height: float
@export var up_speed: float
 
@export_tool_button("Close Doors") var close_doors_action = close_doors
@export_tool_button("Open Doors") var open_doors_action = open_doors
 
var tween: Tween 
var starting_y: float
	 
func _ready() -> void:
	tween = create_tween() 
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	starting_y = global_position.y
	 
	for button: LiftButton in buttons.get_children():
		button.button_pressed.connect(change_floor)
		 
func change_floor(floor: int) -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	# Close doors
	tween.tween_property(lift_door, "position:z", -1.0, 1.0)
	tween.parallel().tween_property(lift_door_2, "position:z", 1.0, 1.0)
	# Switch floor
	tween.tween_property(self, "global_position:y", starting_y + (floor-1) * floor_height, 2.0)
	# Open doors
	tween.tween_property(lift_door, "position:z", -2.5, 1.0)
	tween.parallel().tween_property(lift_door_2, "position:z", 2.5, 1.0)

func close_doors() -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(lift_door, "position:z", -1.0, 1.0)
	tween.parallel().tween_property(lift_door_2, "position:z", 1.0, 1.0)

func open_doors() -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(lift_door, "position:z", -2.5, 1.0)
	tween.parallel().tween_property(lift_door_2, "position:z", 2.5, 1.0)
