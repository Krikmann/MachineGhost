extends StaticBody3D

func interact() -> void:
	var hand = Services.player.hand_slot

	if hand.get_child_count() == 0:
		print("You're not holding anything!")
		return

	var item = hand.get_child(0)

	for child in get_children():
		if child.has_method("check_item"):
			child.check_item(item)
