extends CanvasLayer

@export var panel: PanelContainer
@export var label: Label


func change_text(text) -> void:
	label.text = text
