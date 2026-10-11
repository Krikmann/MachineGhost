class_name SpecialWashingMachine extends StaticBody3D

@export var camera_path: Array[Marker3D] 
@export var camera_point_speeds: Array[float] 
@export var door: MeshInstance3D

@export var can_interact: bool = true
 
func _ready() -> void:
	Services.special_washing_machine = self

var has := false 
func interact() -> void:
	if !can_interact: return
	
	if !has: GameState.trigger_main_sb_response(5)
	has = true 
	
	var player: Player = Services.player 
	player.disable_collision()
	 
	var tween := create_tween()
	 
	for i in range(len(camera_point_speeds)):
		var cam_path_point := camera_path[i]
		tween.tween_property(player, "global_position", cam_path_point.global_position - Vector3(0.0, 2.0, 0.0), camera_point_speeds[i]) 
	 
	player.enable_collision() 
