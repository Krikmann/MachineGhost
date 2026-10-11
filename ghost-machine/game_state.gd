extends Node

signal door_hint_added(hint_text: String)
signal clear_door_hints()  
 
var found_door_hints: Array[String] = []
var current_puzzle: int = 0
 
const SB_MAIN_PATHS := [
	"res://SPIRITBOX_MAIN/1.mp3",
	"res://SPIRITBOX_MAIN/2.mp3",
	"res://SPIRITBOX_MAIN/3.mp3",
	"res://SPIRITBOX_MAIN/4.mp3",
	"res://SPIRITBOX_MAIN/5.mp3",
	"res://SPIRITBOX_MAIN/6.mp3",
	"res://SPIRITBOX_MAIN/7.mp3",
]
const SB_P1_NEIGHBOUR_PATHS := [
	"res://SPIRITBOX_P1_N/1.mp3",
	"res://SPIRITBOX_P1_N/2.mp3",
	"res://SPIRITBOX_P1_N/3.mp3",
	"res://SPIRITBOX_P1_N/4.mp3",
	"res://SPIRITBOX_P1_N/5.mp3",
]
const SP_P1_HINTS_PATHS := [
	"res://SPIRITBOX_P1/1.mp3",
]
const SP_P2_HINTS_PATHS := [
	"res://SPIRITBOX_P2/1.mp3",
	"res://SPIRITBOX_P2/2.mp3",
	"res://SPIRITBOX_P2/3.mp3",
	"res://SPIRITBOX_P2/4.mp3",
]
const SP_P3_HINTS_PATHS := [
	"res://SPIRITBOX_P3/1.mp3",
	"res://SPIRITBOX_P3/2.mp3",
	"res://SPIRITBOX_P3/3.mp3",
	"res://SPIRITBOX_P3/4.mp3",
	"res://SPIRITBOX_P3/5.mp3",
]

var sb_main: Array[AudioStream] = []
var sb_p1_neighbour: Array[AudioStream] = []
var sp_p1_hints: Array[AudioStream] = []
var sp_p2_hints: Array[AudioStream] = []
var sp_p3_hints: Array[AudioStream] = []


func _ready() -> void:
	sb_main = _load_all(SB_MAIN_PATHS)
	sb_p1_neighbour = _load_all(SB_P1_NEIGHBOUR_PATHS)
	sp_p1_hints = _load_all(SP_P1_HINTS_PATHS)
	sp_p2_hints = _load_all(SP_P2_HINTS_PATHS)
	sp_p3_hints = _load_all(SP_P3_HINTS_PATHS)


func _load_all(paths: Array) -> Array[AudioStream]:
	var out: Array[AudioStream] = []
	for p in paths:
		var s := load(p) as AudioStream
		if s == null:
			push_error("Failed to load audio: " + p)
			continue
		out.append(s)
	return out
 
# TRIGER MAIN RESPONSE
func trigger_main_sb_response(i: int) -> void:
	if i < 0 or i >= sb_main.size(): return
	Services.global_audio.stream = sb_main[i]
	Services.global_audio.play()

# TRIGGER NEIGHBOUR RESPONSE 
func trigger_p1_neighbour_response(i: int) -> void:
	if i < 0 or i >= sb_p1_neighbour.size(): return
	Services.global_audio.stream = sb_p1_neighbour[i]
	Services.global_audio.play()
	 
# TRIGGER HINT RESPONSE 
func trigger_hint_response() -> void:
	var pool: Array[AudioStream]
	match current_puzzle:
		1: pool = sp_p1_hints
		2: pool = sp_p2_hints
		3: pool = sp_p3_hints
		_: return
	if pool.is_empty(): return
	
	var s: AudioStream
	if current_puzzle == 3:
		s = third_pool_hint()
	else:
		s = pool[randi() % pool.size()]
	Services.global_audio.stream = s
	Services.global_audio.play()
 
# P1 HINTS TO NOTES 
func add_door_hint(hint: String) -> void:
	print("adding hint", hint) 
	if hint in found_door_hints: 
		print("RETURNING") 
		return
	found_door_hints.append(hint)
	door_hint_added.emit(hint)
	if found_door_hints.size() == 5: open_correct_room()

func correct_room_found() -> void: 
	found_door_hints.clear()
	clear_door_hints.emit()

# P2 START 
func open_correct_room() -> void:
	Services.friend_door.can_interact = true
	current_puzzle = 2 
	# TODO Play something happened sound
 
# P3 START 
func start_puzzle_3() -> void:
	current_puzzle = 3
	Services.special_washing_machine.can_interact = true
	# TODO Play something happened sound
	 
	 
func third_pool_hint() -> AudioStream:
	var floor_2_y = 1.0 # teise korruse poranda korgus
	var floor_3_y = 8.0 # kolmanda korruse poranda korgus
	var very_hot_dist = 6.0
	var hot_dist = 12.0
	var warm_dist = 25.0
	var cold_dist = 50.0
	
	
	var current_player_pos = Services.player.global_position
	var item_pos = Services.special_washing_machine.global_position
	
	var current_dist = current_player_pos.distance_to(item_pos)
	
	if current_player_pos.y > floor_3_y:
		#print("Very Cold")
		return sp_p3_hints[0]
	elif current_player_pos.y > floor_2_y:
		if current_dist < warm_dist:
			#print("Getting Warmer")
			return sp_p3_hints[2]
		elif current_dist < cold_dist:
			#print("Cold")
			return sp_p3_hints[1]
		else:
			#print("Very Cold")
			return sp_p3_hints[0]
	else:
		if current_dist < very_hot_dist:
			#print("Very hot")
			return sp_p3_hints[4]
		elif current_dist < hot_dist:
			#print("Hot")
			return sp_p3_hints[3]
		elif current_dist < warm_dist:
			#print("Getting Warmer")
			return sp_p3_hints[2]
		elif current_dist < cold_dist:
			#print("Cold")
			return sp_p3_hints[1]
		else:
			#print("Very cold")
			return sp_p3_hints[0]
	return sp_p3_hints[0]
	#return AudioStreamWAV.new()

func load_dorm() -> void:
	get_tree().change_scene_to_file("res://Content/main.tscn")
