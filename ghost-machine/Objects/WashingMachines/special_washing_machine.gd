extends StaticBody3D

@export var camera_path: Array[Marker3D] 
@export var camera_point_speeds: Array[float] 
 
var can_interact: bool = true

func interact() -> void:
	if !can_interact: return
	
	var player := Services.player 
	player.disable_collision()
	 
	var tween := create_tween()
	 
	for i in range(camera_path.count): 
		var cam_path_point := camera_path[i] 
		tween.tween_property(player, "global_position", cam_path_point.global_position, camera_point_speeds[i]) 
	 
	player.enable_collision() 
