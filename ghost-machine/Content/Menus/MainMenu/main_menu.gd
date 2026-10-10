extends CanvasLayer

const MAIN = preload("uid://cjmby5iqx70im")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
