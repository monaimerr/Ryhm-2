extends Node

@onready var everything = preload("res://resources/items/potions/potion_of_everything.tres")
@onready var illIntent = preload("res://resources/items/potions/potion_of_ill_intent.tres")
@onready var invisibility = preload("res://resources/items/potions/potion_of_invisibility.tres")

func _ready() -> void:
	$DayProgressManager.day_over.connect($game_level/OpenSign.close_shop)
	$game_level/OpenSign.shop_opened_status_changed.connect(_shop_opened_or_closed)
	
	# Adds a few potions to the players inventory for testing purposes
	InventoryManager.add_item(everything)
	InventoryManager.add_item(illIntent)
	InventoryManager.add_item(invisibility)
	
func _shop_opened_or_closed(open: bool) -> void:
	if open:
		$DayProgressManager.start_day()
	else:
		$DayProgressManager.end_day_early()
