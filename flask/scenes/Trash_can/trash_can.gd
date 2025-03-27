extends Node2D

# This is the trash can's interaction handler
# It has an "interact_name", which is the text shown when the player can
# interact with the interaction handler
# It also has functions "interact" and "interact2" for handling two different
# kinds of interactions
# You overwrite these with your own values to customize
@onready var interactable = $Interactable

func _ready() -> void:
	# Show this text when the player can interact with the interaction handler
	interactable.interact_name = "[E] to empty your inventory"
	# When the interaction handler is interacted with, run "_interact"
	interactable.interact = _interact

func _interact() -> void:
	var playerInv = InventoryManager.playerInv
