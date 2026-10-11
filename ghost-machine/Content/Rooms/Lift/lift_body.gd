class_name LiftBody extends AnimatableBody3D

signal change_floor(to_floor: int)

@export var move_stream_player: AudioStreamPlayer3D
@export var ding_stream_player: AudioStreamPlayer3D


func _on_floor_1_button_button_pressed(f: Variant) -> void: change_floor.emit(f)
func _on_floor_2_button_button_pressed(f: Variant) -> void: change_floor.emit(f)
func _on_floor_3_button_button_pressed(f: Variant) -> void: change_floor.emit(f)
