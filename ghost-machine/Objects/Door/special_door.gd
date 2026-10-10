@tool
class_name SpecialDoor extends StaticBody3D

@export_tool_button("Door Open") var openginDoor = interact

@onready var cube: MeshInstance3D
@onready var cube_001: MeshInstance3D
 
@export var DoorAnchor: Node3D
@export var label: Label3D
@export var door_number: int = 283 
 

@export var OpenRotation: float = 90.0
@export var Duration: float = 1.0

@export var IsOpen: bool = false
 
var can_interact: bool = false
 
var ClosedRotation: float = 0.0 

func _ready() -> void: 
	if DoorAnchor: ClosedRotation = DoorAnchor.rotation_degrees.y 
	set_door_number(door_number) 

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

func set_door_number(nr: int) -> void: 
	door_number = nr 
	label.text = str(nr) 
 
func clear_overlay() -> void:
	cube = $DoorAnchor/uks/Cube
	cube_001 = $DoorAnchor/uks/Cube_001
	cube.material_overlay = null
	cube_001.material_overlay = null 
	
