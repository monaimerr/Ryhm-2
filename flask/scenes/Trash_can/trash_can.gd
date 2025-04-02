extends Node2D

@onready var interactable = $Interactable
@onready var trashSound = $trashSound

var playerInv = InventoryManager.playerInv
var selected_index = 0  

func _ready() -> void:
	interactable.interact_name = "[E] to delete an item"
	interactable.interact = _interact

func _interact() -> void:
	if playerInv.size() > 0:
		var item_to_remove = playerInv[selected_index]
		InventoryManager.remove_item(item_to_remove)
		print("Removed: " + str(item_to_remove))
		trashSound.play()
		
		if playerInv.size() == 0:
			print("Inventory is now empty!")
	else:
		print("Inventory is already empty!")
