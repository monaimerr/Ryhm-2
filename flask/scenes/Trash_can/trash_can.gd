extends Node2D

# Called when a body enters the area (e.g., when a potion touches the trash can).
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Check if the entered body is a potion (make sure potions are in the "potion" group)
	if body.is_in_group("potion"):
		print("Potion entered the trash can area!")
		# You could also add some interaction here to highlight or mark the potion for removal

# Called when the user clicks on the trash can (input event)
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	# Detect if the mouse was clicked
	if event is InputEventMouseButton and event.pressed:
		var inv = InventoryManager.playerInv  # Reference to player's inventory
		if inv.size() > 0:  # Ensure the inventory has items
			var potion_to_remove = inv[0]  # Example: Remove the first potion (could be customized)
			InventoryManager.remove_item(potion_to_remove)  # Remove the potion from the inventory
			print(potion_to_remove + " discarded.")  # Print confirmation
