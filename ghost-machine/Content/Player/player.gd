class_name Player extends CharacterBody3D
 
@export var collision_shape: CollisionShape3D

@export var sensitivity := 0.002
@export var cam: Camera3D
 
@export var interact_ray: Interaciton
@export var hand_slot: Node3D

const SPEED = 5.0
const SPRINT_SPEED = 15.0
const JUMP_VELOCITY = 4.5

var current_speed = SPEED
var held_item: Node3D = null


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
	 
func _get_sb_speech():
	held_item.speech()

func disable_collision() -> void: collision_shape.disabled = true
func enable_collision() -> void: collision_shape.disabled = false 
	
