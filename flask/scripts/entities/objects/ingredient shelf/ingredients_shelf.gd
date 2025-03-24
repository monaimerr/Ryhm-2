## The code in this file is copied from, modified, or is otherwise based on the code in the following public repository:
##     https://github.com/QuebleGameDev/Godot---2D-Interaction
## Used with permission based on the following terms:
##     "Feel free to clone this repo, and/or use any of this code for whatever projects you'd like!"

extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var count_label: Label = $Label

@export var item: Item
@export var item_count: int = 3
@export var texture: Texture2D
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	interactable.interact = _on_interact
	interactable.interact2 = _on_interact2
	sprite_2d.texture = texture
	count_label.text = str(item_count)
	

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
