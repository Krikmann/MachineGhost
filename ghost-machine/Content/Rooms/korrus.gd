extends StaticBody3D

@export var korruse_nr: int
@export var label_3d: Label3D

func _ready() -> void:
	label_3d.text = str(korruse_nr)
