class_name HUD extends CanvasLayer

@export var interaction_label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Services.hud = self


func show_interactiontext() -> void:
	if interaction_label:
		interaction_label.visible = true
	
func hide_interactiontext() -> void:
	if interaction_label:
		interaction_label.visible = false
