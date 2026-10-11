@tool
class_name Door extends Node3D

@export_tool_button("Door Open") var openginDoor = interact

@export var DoorAnchor: Node3D
@export var label: Label3D

@export var OpenRotation: float = 90.0
@export var Duration: float = 1.0
@export var StartsLocked: bool = true 
@export var door_number: int 

@export var IsOpen: bool = false
@export var IsNeighbour: bool = false
var ClosedRotation: float = 0.0
 
var locked: bool  
@export var audio_stream_player_3d: AudioStreamPlayer3D
@export var close_door_stream_player: AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_door_number(door_number) 
	locked = StartsLocked
	if DoorAnchor:
		ClosedRotation = DoorAnchor.rotation_degrees.y

func interact() -> void:
	if IsOpen:
		close_door()
	else:
		open_door()

func open_door() -> void:
	if IsOpen: return 
	IsOpen = true
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(
	   	DoorAnchor,
		"rotation_degrees:y",
		ClosedRotation + OpenRotation,
		Duration
	)
	audio_stream_player_3d.play()
	
	if IsNeighbour:
		call_neighbour()
	
func close_door() -> void:
	if !IsOpen: return
	IsOpen = false
	var tween = create_tween()
	tween.tween_property(
	   	DoorAnchor,
		"rotation_degrees:y",
		ClosedRotation,
		Duration
	)
	audio_stream_player_3d.play()
	tween.tween_callback(play_close_door_audio)
	if IsNeighbour:
		leave_neighbour()


func _on_area_3d_interacted() -> void:
	interact()

func call_neighbour() -> void:
	var text = get_parent_node_3d().hint
	if not GameState.found_door_hints.has(text): GameState.add_door_hint(text)
	get_parent_node_3d().get_node("AnimationPlayer").play("new_animation")
	var ui = get_parent_node_3d().get_parent_node_3d().get_node("UI")
	var panel = ui.get_node("PanelContainer")
	panel.show()
	panel.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(panel, "modulate:a", 1.0, 0.3)
	get_parent_node_3d().get_parent_node_3d().get_node("UI").change_text(text)
	await get_tree().create_timer(8.0).timeout
	hide_text()
	close_door() 

func leave_neighbour() -> void:
	get_parent_node_3d().get_node("AnimationPlayer").play_backwards("new_animation")
	hide_text()

func hide_text() -> void:
	var ui = get_parent_node_3d().get_parent_node_3d().get_node("UI")
	var panel = ui.get_node("PanelContainer")
	var tween = create_tween()
	tween.tween_property(panel, "modulate:a", 0.0, 0.3)
	await tween.finished
	panel.hide()

func set_door_number(nr: int) -> void: 
	door_number = nr 
	label.text = str(nr) 
	
	
func play_close_door_audio() -> void:
	close_door_stream_player.play()
