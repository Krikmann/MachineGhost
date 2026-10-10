extends StaticBody3D

@export var camera_path: Array[Marker3D] 
@export var camera_point_speeds: Array[float] 
@export var door: MeshInstance3D

var can_interact: bool = false

func interact() -> void:
	if !can_interact: return
	
	var player: Player = Services.player 
	player.disable_collision()
	 
	var tween := create_tween()
	 
	for i in range(len(camera_point_speeds)):
		var cam_path_point := camera_path[i]
		tween.tween_property(player, "global_position", cam_path_point.global_position - Vector3(0.0, 2.0, 0.0), camera_point_speeds[i]) 
	 
	player.enable_collision() 
