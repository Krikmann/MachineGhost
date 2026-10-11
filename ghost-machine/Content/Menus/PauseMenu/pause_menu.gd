class_name PauseMenu extends CanvasLayer

const MAIN_MENU = preload("uid://c2nl407g0akrk")

@export var root: Control
 
func _ready() -> void:
	unpause()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"): pause()

func unpause() -> void:
	get_tree().paused = false
	visible = false
	root.mouse_filter = Control.MOUSE_FILTER_IGNORE
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func pause() -> void:
	get_tree().paused = true
	visible = true
	root.mouse_filter = Control.MOUSE_FILTER_STOP
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_continue_button_pressed() -> void:
	print("CONTINUE") 
	unpause()

func _on_quit_button_pressed() -> void:
	print("QUIT") 
	get_tree().quit() 


func _on_restart_button_pressed() -> void:
	print("RESTART") 
	get_tree().reload_current_scene() 
	 
