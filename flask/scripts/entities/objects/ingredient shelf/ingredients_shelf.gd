## The code in this file is copied from, modified, or is otherwise based on the code in the following public repository:
##     https://github.com/QuebleGameDev/Godot---2D-Interaction
## Used with permission based on the following terms:
##     "Feel free to clone this repo, and/or use any of this code for whatever projects you'd like!"

extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var count_label: Label = $Label
@onready var bought_label: Label = $BoughtLabel
@onready var order_complete_timer: Timer = $OrderCompleteTimer

@export var item: Item
@export var item_count: int = 3
@export var price: int
@export var texture: Texture2D
@onready var sprite_2d: Sprite2D = $Sprite2D
var ordered_count: int = 0


func _ready() -> void:
	interactable.interact = _on_interact
	interactable.interact2 = _on_interact2
	interactable.interact3 = _on_interact3
	sprite_2d.texture = texture
	count_label.text = str(item_count)
	
	interactable.interact_name = str("[E] Get item, [R] return item, [C] to buy ingredient. Price: ", price)
	

func _on_interact():
	if item_count > 0:
		if InventoryManager.add_item(item):
			item_count = item_count - 1
			#print(item_count)
			count_label.text = str(item_count)
		

func _on_interact2():
	if InventoryManager.remove_item(item):
		item_count = item_count + 1
		#print(item_count)
		count_label.text = str(item_count)
		
func _on_interact3():
	if MoneyManager.remove_money(price):
		print("Item bought!")
		ordered_count += 1
		bought_label.text = str("+", ordered_count)
		order_complete_timer.start()
	else:
		print("not enough money!")
	
	
	
func add_ordered_items():
	item_count += ordered_count
	ordered_count = 0
	
	count_label.text = str(item_count)
	bought_label.text = ""
	


func _on_order_complete_timer_timeout() -> void:
	add_ordered_items()
