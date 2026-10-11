extends StaticBody3D

var can_pickup: bool = false
var can_interact: bool = true

func interact() -> void:
	var hand = Services.player.hand_slot
	if can_pickup:
		if hand.get_child_count() > 0:
			print("Your hands are full!")
			return
			
		can_interact = false
		reparent(hand)
		transform = Transform3D.IDENTITY
		collision_layer = 0
		collision_mask = 0

		print("Box picked up!")
		return

	if hand.get_child_count() == 0:
		print("You're not holding anything!")
		return

	var item = hand.get_child(0)

	for child in get_children():
		if child.has_method("check_item"):
			child.check_item(item)
	check_all_items()

func check_all_items() -> void:
	can_pickup = true

	for child in get_children():
		if child.has_method("is_collected"):
			if not child.is_collected():
				can_pickup = false
				break

	if can_pickup:
		print("All items collected! You can pick up the box!")
