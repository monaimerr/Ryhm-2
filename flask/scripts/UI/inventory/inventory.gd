extends Control

@onready var playerInv = InventoryManager.playerInv
@onready var slots = $GridContainer.get_children()
@onready var invSize = InventoryManager.playerInvSize

func _ready() -> void:
	InventoryManager.inventory_changed.connect(update_slots)
	update_slots()


func update_slots():
	for i in range(invSize):
		if (i < playerInv.size()):
			slots[i].texture_rect.texture = playerInv[i].texture
		else:
			slots[i].texture_rect.texture = null
			
		
	
