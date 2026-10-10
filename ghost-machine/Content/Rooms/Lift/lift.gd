@tool
extends RigidBody3D

@export var lift_door: StaticBody3D
@export var lift_door_2: StaticBody3D
 
@export var floor_height: float 
 
func change_floor() -> void:
	# TODO Close doors
	close_doors() 
	# TODO Switch floor
	# TODO Open doors
	
func close_doors() -> void:
	var tween := Tween.new()
	#tween.tween_property(lift_door.) 
	
