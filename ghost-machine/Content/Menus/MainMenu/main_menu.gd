extends CanvasLayer

const HOME = preload("uid://bbi2nkgbm4ai")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(HOME) 


func _on_quit_button_pressed() -> void:
	get_tree().quit()
