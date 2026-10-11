@tool 
class_name OuterLiftParts extends Node3D

@export_tool_button("Close Doors") var close_doors_action = close_doors
@export_tool_button("Open Doors") var open_doors_action = open_doors
 
signal call_lift(floor_nr) 
 
@export var floor_nr: int 
@export var lift_door: LiftDoor
@export var lift_door_2: LiftDoor
@export var call_button: LiftButton

@export var opening_and_closing_stream_player: AudioStreamPlayer3D
@export var open_sound: AudioStream
@export var close_sound: AudioStream
 
func _ready() -> void:
	call_button.to_floor = floor_nr
	if floor_nr == 1: open_doors()

func close_doors() -> void:
	lift_door.close()
	lift_door_2.close()
	
	opening_and_closing_stream_player.stream = close_sound
	opening_and_closing_stream_player.play()

func open_doors() -> void:
	lift_door.open()
	lift_door_2.open()
	
	opening_and_closing_stream_player.stream = open_sound
	opening_and_closing_stream_player.play()

func _on_call_button_button_pressed(f: Variant) -> void:
	call_lift.emit(f) 
