extends CanvasLayer

@export var panel: PanelContainer
@export var label: Label
@export var notes: MarginContainer
@export var labels: Array[Label] = []
@export var hint_label: PanelContainer

func _ready() -> void:
	hints_cleared() 
	GameState.door_hint_added.connect(hint_added)
	GameState.clear_door_hints.connect(hints_cleared)

func hint_added(hint_text: String) -> void:
	show_notes() 
	for l in labels: 
		if l.text == "":
			l.text =  hint_text
			break 

func hints_cleared() -> void:
	for l in labels: l.text = ""
	hide_notes() 

func show_notes() -> void: notes.visible = true
func hide_notes() -> void: notes.visible = false
 
func change_text(text) -> void:
	label.text = text
 
var _last_playing := false
func _process(_delta: float) -> void:
	if label.text == "": panel.visible = false
	else: panel.visible = true 
	 
	if Services and Services.global_audio and Services.global_audio.playing and hint_label: hint_label.hide()
	elif hint_label: hint_label.show() 
