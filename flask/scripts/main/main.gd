extends Node

@onready var everything = preload("res://resources/items/potions/potion_of_everything.tres")
@onready var illIntent = preload("res://resources/items/potions/potion_of_ill_intent.tres")
@onready var invisibility = preload("res://resources/items/potions/potion_of_invisibility.tres")
@onready var newDaySound = $newDaySound

func _ready() -> void:
	# Hooking up signals for day-night cycle
	$DayProgressManager.new_day_begun.connect(_new_day_begun)
	$DayProgressManager.time_updated.connect(_update_time_display)
	$DayProgressManager.shop_open_time_over.connect(_shop_open_time_over)
	$game_level/OpenSign.shop_opened_status_changed.connect(_shop_opened_or_closed)
	$game_level/Bed.sleeping.connect($DayProgressManager.start_new_day)
	
	# Adds a few potions to the players inventory for testing purposes
	InventoryManager.add_item(everything)
	InventoryManager.add_item(illIntent)
	InventoryManager.add_item(invisibility)

func _new_day_begun() -> void:
	$game_level/OpenSign.on_day_changed()
	newDaySound.play()
	

func _shop_open_time_over() -> void:
	$game_level/OpenSign.close_shop()

func _shop_opened_or_closed(open: bool) -> void:
	if open:
		$DayProgressManager.when_shop_opened()
	else:
		$DayProgressManager.when_shop_closed_early()

func _update_time_display(elapsed_seconds: int) -> void:
	var display = $UserInterfaceLayer/DayProgressDisplay
	display.text = "Time of Day: %d" % (elapsed_seconds)
