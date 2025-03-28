extends Control

@onready var grid_container = $GridContainer  # Reference to GridContainer
@onready var close_button = $GridContainer/CloseButton
@onready var love_potion_button = $GridContainer/LovePotionButton
@onready var ill_intent_potion_button = $GridContainer/IllIntentPotionButton
@onready var strength_potion_button = $GridContainer/StrengthPotionButton
@onready var invisibility_potion_button = $GridContainer/InvisibilityPotionButton
@onready var healing_potion_button = $GridContainer/HealingPotionButton
@onready var everything_potion_button = $GridContainer/EverythingPotionButton

var recipes = {
	"Potion of Love": ["Water", "Shard of Love", "Shard of Love", "Dawn light dust", "Hollyhock"],
	"Potion of Ill Intent": ["Mysterious Liquid", "Shard of Intent", "Shard of Space", "Twilight glow dust", "Spruce Needle", "Spruce Needle"],
	"Potion of Strength": ["Mysterious Liquid", "Shard of Intent", "Birch leaf", "Lavender"],
	"Potion of Invisibility": ["Water", "Shard of Nothing", "Maple seed", "Maple seed"],
	"Potion of Healing": ["Water", "Shard of Time", "Shard of Love", "Birch leaf", "Dawn light dust"],
	"Potion of Everything": ["Mysterious Liquid", "Shard of Space", "Shard of Time", "Shard of Love", "Shard of Nothing", "Shard of Intent", "Twilight glow dust", "Dawn light dust", "Lavender"]
}

func _ready() -> void:
	# set a reasonable minimum size
	self.custom_minimum_size = Vector2(400, 300)
	self.size = Vector2(400, 300)
	

	print_tree()
	print("CauldronMenu Ready! Path:", get_path())
	print("Children of CauldronMenu:", get_children())


	print("CauldronMenu Ready! Position:", position, "Size:", size)
	# connect button signals safely
	connect_button(love_potion_button, "Potion of Love")
	connect_button(ill_intent_potion_button, "Potion of Ill Intent")
	connect_button(strength_potion_button, "Potion of Strength")
	connect_button(invisibility_potion_button, "Potion of Invisibility")
	connect_button(healing_potion_button, "Potion of Healing")
	connect_button(everything_potion_button, "Potion of Everything")

	if close_button:
		close_button.pressed.connect(_on_close_pressed)
	else:
		print("ERROR: CloseButton not found!")

func connect_button(button: TextureButton, potion_name: String) -> void:
	if button:
		button.pressed.connect(_on_potion_selected.bind(potion_name))
	else:
		print("ERROR: Button for", potion_name, "not found!")

func _on_potion_selected(potion_name: Item) -> void:
	if potion_name in recipes:
		craft_potion(potion_name, recipes[potion_name])
	else:
		print("ERROR: No recipe defined for", potion_name)

func has_required_items(required_items: Array) -> bool:
	var inventory = InventoryManager.playerInv
	var temp_inventory = inventory.duplicate(true)  # duplicate to avoid modifying original inventory

	for req in required_items:
		var found = false
		for item in temp_inventory:
			if item.name == req:
				temp_inventory.erase(item)
				found = true
				break
		if not found:
			return false
	return true

func craft_potion(potion_name: Item, required_items: Array) -> void:
	if not has_required_items(required_items):
		print("CRAFTING FAILED: missing ingredients for", potion_name)
		return

	# remove required ingredients
	for req in required_items:
		var item_to_remove = null
		for item in InventoryManager.playerInv:
			if item.name == req:
				item_to_remove = item
				break
		if item_to_remove:
			InventoryManager.remove_item(item_to_remove)
		else:
			print("ERROR: Tried to remove", req, "but it wasn't found in inventory!")

	# create potion item
	var potion = InventoryManager.add_item(potion_name)
	if potion is Item:
		InventoryManager.add_item(potion)
		print(potion_name, "crafted successfully!")
	else:
		print("ERROR: Failed to create potion", potion_name)

func _on_close_pressed():
	visible = false  # just hide the menu instead of deleting it
