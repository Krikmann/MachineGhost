class_name Player extends CharacterBody3D
 
@export var collision_shape: CollisionShape3D

@export var sensitivity := 0.002
@export var cam: Camera3D
 
@export var interact_ray: Interaciton
@export var hand_slot: Node3D

@export var footsteps_stream_player: AudioStreamPlayer3D
@export var footstep_sound_effects: Array[AudioStream] = []

const SPEED = 5.0
const SPRINT_SPEED = 15.0
const JUMP_VELOCITY = 4.5

var current_speed = SPEED
var held_item: Node3D = null

var distance_for_footstep = 2
var last_position : Vector2

func _ready() -> void:
	Services.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	# Camera movement
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity)
		cam.rotate_x(-event.relative.y * sensitivity)
		cam.rotation.x = clamp(cam.rotation.x, -1.5, 1.5)
	
	if event.is_action_pressed("sb_voice"):
		if held_item:
			if !held_item.audio_player.is_playing():
				_get_sb_speech()
	 
	if event.is_action_pressed("sprint"): current_speed = SPRINT_SPEED
	if event.is_action_released("sprint"): current_speed = SPEED
		

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor(): velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
	
	var current2dPos = Vector2(self.global_position.x, self.global_position.z)
	var dist = current2dPos.distance_to(last_position)
	
	if dist >= distance_for_footstep:
		if self.is_on_floor():
			play_random_footstep()
		last_position = current2dPos
			
	 
func _get_sb_speech():
	held_item.speech()

func disable_collision() -> void: collision_shape.disabled = true
func enable_collision() -> void: collision_shape.disabled = false 
	
func play_random_footstep() -> void:
	if footstep_sound_effects.is_empty() or not footsteps_stream_player:
		return
		
	var random_step = footstep_sound_effects.pick_random()
	
	footsteps_stream_player.pitch_scale = randf_range(0.92, 1.08)
	footsteps_stream_player.volume_db = randf_range(-3.0, 0.0)
	footsteps_stream_player.stream = random_step
	footsteps_stream_player.play()
