@tool
class_name Lift extends Node3D

@export var lift_body: AnimatableBody3D
@export var floors: Array[OuterLiftParts] = [] 
@export var floor_height: float
 
@export_tool_button("Close Doors") var close_doors_action = close_doors
@export_tool_button("Open Doors") var open_doors_action = open_doors
@export_tool_button("Chang Floor") var change_floor_action = cf
 
var current_floor: int = 1 
var lift_body_starting_position_y: float
 
func cf() -> void:
	if current_floor == 3: change_floor(1)
	else: change_floor(current_floor + 1)
 
func _ready() -> void:
	lift_body_starting_position_y = lift_body.global_position.y

func change_floor(to_floor: int) -> void:
	if to_floor == current_floor: return 
	 
	# Close doors
	close_doors_on_floor(current_floor)
	 
	# Switch floor 
	 
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_interval(2.0)
	tween.tween_property(lift_body, "global_position:y", lift_body_starting_position_y + (to_floor-1) * floor_height, 2.0)
	current_floor = to_floor
	 
	# Open doors
	tween.tween_callback(open_doors_on_floor.bind(current_floor)) 
	var other_floors = [1,2,3]
	other_floors.erase(current_floor)
	tween.tween_callback(close_doors_on_floor.bind(other_floors[0])) 
	tween.tween_callback(close_doors_on_floor.bind(other_floors[1])) 
	 
func close_doors_on_floor(i: int) -> void: floors[i-1].close_doors()
func open_doors_on_floor(i: int) -> void: floors[i-1].open_doors()
func close_doors() -> void: for f in floors: f.close_doors()
func open_doors() -> void: for f in floors: f.open_doors()
	 
func _on_floor_1_parts_call_lift(floor_nr: Variant) -> void: change_floor(floor_nr)
func _on_floor_2_parts_call_lift(floor_nr: Variant) -> void: change_floor(floor_nr)
func _on_floor_3_parts_call_lift(floor_nr: Variant) -> void: change_floor(floor_nr)
func _on_lift_body_change_floor(to_floor: int) -> void: change_floor(to_floor)
