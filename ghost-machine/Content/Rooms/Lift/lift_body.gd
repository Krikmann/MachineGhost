class_name LiftBody extends AnimatableBody3D

signal change_floor(to_floor: int)
 
func _on_floor_1_button_button_pressed(f: Variant) -> void: change_floor.emit(f)
func _on_floor_2_button_button_pressed(f: Variant) -> void: change_floor.emit(f)
func _on_floor_3_button_button_pressed(f: Variant) -> void: change_floor.emit(f)
