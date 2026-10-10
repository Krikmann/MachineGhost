@tool
class_name SpecialDoor extends StaticBody3D

@export_tool_button("Door Open") var openginDoor = interact

@export var DoorAnchor: Node3D
@export var label: Label3D

@export var OpenRotation: float = 90.0
@export var Duration: float = 1.0

@export var IsOpen: bool = false
 
var ClosedRotation: float = 0.0 

func _ready() -> void:
	if DoorAnchor: ClosedRotation = DoorAnchor.rotation_degrees.y

func interact() -> void:
	if IsOpen: close_door()
	else: open_door()

func open_door() -> void:
	IsOpen = true
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property( DoorAnchor, "rotation_degrees:y", ClosedRotation + OpenRotation, Duration )
	
func close_door() -> void:
	IsOpen = false
	var tween = create_tween()
	tween.tween_property( DoorAnchor, "rotation_degrees:y", ClosedRotation, Duration )

func _on_area_3d_interacted() -> void:
	interact()

func set_label_text(text: String) -> void:
	label.text = text 
	
