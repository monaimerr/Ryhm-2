extends Control
#buttons
@onready var grid_container = $GridContainer 
@onready var close_button = $GridContainer/CloseButton
@onready var love_potion_button = $GridContainer/LovePotionButton
@onready var ill_intent_potion_button = $GridContainer/IllIntentPotionButton
@onready var strength_potion_button = $GridContainer/StrengthPotionButton
@onready var invisibility_potion_button = $GridContainer/InvisibilityPotionButton
@onready var healing_potion_button = $GridContainer/HealingPotionButton
@onready var everything_potion_button = $GridContainer/EverythingPotionButton

#potions
@onready var lovepotion = preload("res://resources/items/potions/potion_of_love.tres")
@onready var illintentpotion = preload("res://resources/items/potions/potion_of_ill_intent.tres")
@onready var strengthpotion = preload("res://resources/items/potions/potion_of_strength.tres")
@onready var invisibilitypotion = preload("res://resources/items/potions/potion_of_invisibility.tres")
@onready var healingpotion = preload("res://resources/items/potions/potion_of_healing.tres")
@onready var everythingpotion = preload("res://resources/items/potions/potion_of_everything.tres")

@onready var refs = {
	"Potion of Love": lovepotion,
	"Potion of Ill Intent": illintentpotion,
	"Potion of Strength": strengthpotion,
	"Potion of Invisibility": invisibilitypotion,
	"Potion of Healing": healingpotion,
	"Potion of Everything": everythingpotion
}

#all recipes
var recipes = {
	"Potion of Love": ["Water", "Shard of Love", "Shard of Love", "Dawn light dust", "Hollyhock"],
	"Potion of Ill Intent": ["Mysterious liquid", "Shard of Intent", "Shard of Space", "Twilight glow dust", "Spruce needle", "Spruce needle"],
	"Potion of Strength": ["Mysterious liquid", "Shard of Intent", "Birch leaf", "Lavender"],
	"Potion of Invisibility": ["Water", "Shard of Nothing", "Maple seed", "Maple seed"],
	"Potion of Healing": ["Water", "Shard of Time", "Shard of Love", "Birch leaf", "Dawn light dust"],
	"Potion of Everything": ["Mysterious liquid", "Shard of Space", "Shard of Time", "Shard of Love", "Shard of Nothing", "Shard of Intent", "Twilight glow dust", "Dawn light dust", "Lavender"]
}

func _ready() -> void:
	position = Vector2(1600, 500) #hardcoded position for now, might change later
	visible = false
	modulate = Color(1,1,1,1)
	z_index = 1
	print(refs.get("Potion of Love").name)

	# connect button signals 
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

func connect_button(button: Button, potion_name: String) -> void:
	if button:
		# use bind to pass potion_name to _on_potion_selected
		button.pressed.connect(_on_potion_selected.bind(potion_name))
	else:
		print("ERROR: Button for", potion_name, "not found!")

func _on_potion_selected(potion_name: String) -> void:
	print("Potion selected:", potion_name)  # check to make sure button works
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
			print("Failed to craft potion: Missing ingredient:", req)  # show which ingredient is missing
			return false
	return true

func craft_potion(potion_name: String, required_items: Array) -> void:
	print("Crafting potion:", potion_name)  # check to make sure the button works

	# check if ingredients are in player inventory
	if not has_required_items(required_items):
		print("Crafting failed: Missing ingredients for", potion_name)
		return

	# remove required ingredients if crafted
	for req in required_items:
		var item_to_remove = null
		for item in InventoryManager.playerInv:
			if item.name == req:
				item_to_remove = item
				break
		if item_to_remove:
			InventoryManager.remove_item(item_to_remove)
			print("Removed item:", item_to_remove.name)  # print to confirm item removal, rm later
		else:
			print("error: Tried to remove", req, "but it wasn't found in inventory!")

	# create the potion object
	var potion = refs.get(potion_name)  # create a new potion instance
	# check to make sure potion crafts, visual not working
	print("Potion created: ", potion.name)

	# add the potion to inventory
	var success = InventoryManager.add_item(potion)
	if success:
		print(potion_name, "crafted successfully!")
		print_inventory()  # Debugging line to confirm inventory content, currently crafted potions appear invisible
	else:
		print("ERROR: Failed to create potion", potion_name)
		

func _on_close_pressed():
	visible = false  # close button functionality
	
func print_inventory() -> void: #debug function to check if the crafted potion exists
	for item in InventoryManager.playerInv:
		print("Inventory item:", item.name)
