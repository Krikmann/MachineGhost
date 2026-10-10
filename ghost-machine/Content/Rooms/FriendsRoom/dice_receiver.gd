extends MeshInstance3D

@export var CorrectName: String

func _ready() -> void:
	hide()

func check_item(item: Node) -> void:
	if item is Pickup and item.item_name == CorrectName:
		show()
		item.queue_free()
		print(item.item_name)
		print("Correct item!")
