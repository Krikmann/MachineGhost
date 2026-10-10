@tool 
extends StaticBody3D

@export var korruse_nr: int
@export var label_3d: Label3D
 
@export_category("Spawning doors")
@export var doors: Node3D
@export var doors_on_this_floor: int
@export var next_door_offset: Vector3 
@export var doors_begin_l: Marker3D 
@export var doors_begin_r: Marker3D 
@export var missing_door_indices_l: Array[int] = []
@export var missing_door_indices_r: Array[int] = []
 
@export_tool_button("Generate Doors") var _gen_btn = _generate_doors
 
const SPECIAL_DOOR = preload("uid://cao0eiv51bi4e")

func _ready() -> void:
	label_3d.text = str(korruse_nr)

func _generate_doors() -> void:
	# Clear existing doors first (children of `doors`)
	for c in doors.get_children():
		c.queue_free()

	var random_nums := range(100)
	if korruse_nr == 1:
		random_nums.pop_at(0)
		random_nums.pop_at(54)
	elif korruse_nr == 2: 
		random_nums.pop_at(82)
		random_nums.pop_at(50)
	elif korruse_nr == 3: 
		random_nums.pop_at(32)
		random_nums.pop_at(68)
		 
	random_nums.shuffle()

	# Left row
	var door_place: Transform3D = doors_begin_l.global_transform
	for i in range(doors_on_this_floor):
		if not i in missing_door_indices_l:
			var inst := SPECIAL_DOOR.instantiate() as SpecialDoor
			doors.add_child(inst)
			inst.owner = get_tree().edited_scene_root   # so it saves in the scene
			inst.global_transform = door_place
			inst.IsOpen = false
			inst.can_interact = false
			inst.set_door_number(korruse_nr * 100 + random_nums.pop_back())
			inst.clear_overlay() 
		door_place.origin += next_door_offset

	# Right row
	door_place = doors_begin_r.global_transform
	for i in range(doors_on_this_floor):
		if not i in missing_door_indices_r:
			var inst := SPECIAL_DOOR.instantiate() as SpecialDoor
			doors.add_child(inst)
			inst.owner = get_tree().edited_scene_root
			inst.global_transform = door_place
			inst.IsOpen = false
			inst.can_interact = false
			inst.set_door_number(korruse_nr * 100 + random_nums.pop_back())
			inst.clear_overlay() 
		door_place.origin += next_door_offset
