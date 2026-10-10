class_name Interaciton extends RayCast3D


@onready var prompt
var collider
var last_collider

var CanInteractVar : String = "can_interact"

func _physics_process(_delta: float) -> void:
	if is_colliding():
		collider = get_collider()
		
		if CanInteractVar in collider:
			if collider.get(CanInteractVar) == true:
				# Can currently interact with object
				
				_set_overlay_strength(collider, 1.0)
				if collider and collider.has_method("interact"):
					Services.hud.show_interactiontext()
				else:
					Services.hud.hide_interactiontext()
				
				if last_collider != collider:
					_set_overlay_strength(last_collider, 0.0)
					last_collider = collider
			else:
				# Cant currently interact with object
				return
		
		_set_overlay_strength(collider, 1.0)
		
		if collider and collider.has_method("interact"):
			Services.hud.show_interactiontext()
		else:
			Services.hud.hide_interactiontext()
		
		if last_collider != collider:
			_set_overlay_strength(last_collider, 0.0)
			last_collider = collider

		
	else:
		if not collider:
			Services.hud.hide_interactiontext()
		_set_overlay_strength(collider, 0.0)
		collider = null


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if collider and collider.has_method("interact"):
			if CanInteractVar in collider:
				if collider.get(CanInteractVar) == true:
					collider.interact()
			else:
				collider.interact()


func _set_overlay_strength(target_node: Node3D, strength: float) -> void:
	if not is_instance_valid(target_node): 
		return
		
	# Using "GeometryInstance3D" catches all types of 3D meshes no matter their node names
	var meshes = target_node.find_children("*", "MeshInstance3D")
	
	for mesh in meshes:
		if mesh.material_overlay: #and mesh.material_overlay.get_shader_parameter("overlay_strength") != null:
			# Checking the shader's uniform list is much safer than checking parameter data values
			#var shader = mesh.material_overlay.get("shader")
			mesh.set_instance_shader_parameter("overlay_strength", strength)
