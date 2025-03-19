## The code in this file is copied from, modified, or is otherwise based on the code in the following public repository:
##     https://github.com/QuebleGameDev/Godot---2D-Interaction
## Used with permission based on the following terms:
##     "Feel free to clone this repo, and/or use any of this code for whatever projects you'd like!"

extends StaticBody2D

@onready var interactable: Area2D = $Interactable

@export var item: Item
@export var texture: Texture2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var item_count: int = 3

func _ready() -> void:
	interactable.interact = _on_interact
	sprite_2d.texture = texture
	

func _on_interact():
	
	## if Input.is_action_pressed("click"):
		
	
	if item.type == Item.Type.INGREDIENT and item_count > 0:
		InventoryManager.add_item(item)
		item_count = item_count - 1
		print(item_count)
	
	
