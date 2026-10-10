extends CanvasLayer

@export var panel: PanelContainer
@export var label: Label


func change_text(text) -> void:
	label.text = text
 
func _process(delta: float) -> void:
	if label.text == "": panel.visible = false
	else: panel.visible = true 
