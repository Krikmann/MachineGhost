class_name Player extends CharacterBody3D

@export var sensitivity := 0.002
@export var cam: Camera3D

@export var hand_slot: Node3D
@export var pickup_area: Area3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var held_item: Node3D = null

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pickup_area.body_entered.connect(_on_body_entered)
	pickup_area.body_exited.connect(_on_body_exited)

func _unhandled_input(event: InputEvent) -> void:
	# Capture mouse at the start of game
	# TODO move elsewhere later maybe
	#if event.is_action_pressed("quit"): get_tree().quit()
	
	# Camera movement
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity)
		cam.rotate_x(-event.relative.y * sensitivity)
		cam.rotation.x = clamp(cam.rotation.x, -1.5, 1.5)
	
	if event.is_action_pressed("interact"):
		if held_item is Spiritbox:
			_try_pickup()

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
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _on_body_entered(body):
	if body.has_method("pickup"):
		body._can_pickup = true

func _on_body_exited(body):
	if body.has_method("pickup"):
		body._can_pickup = false

func _try_pickup():
	for body in pickup_area.get_overlapping_bodies():
		if body.has_method("pickup"):
			held_item = body
			held_item.pickup(hand_slot)
			return

func _drop():
	held_item.drop()
	held_item = null
