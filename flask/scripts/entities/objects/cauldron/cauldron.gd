extends StaticBody2D

@onready var interactable: Area2D = $Interactable

var player_near = false

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	print("kjkjkj")
	open_menu()
	
func open_menu():
	print("Opening potion crafting menu...")
	var ui = preload("res://scenes/UI/cauldron_menu/cauldronmenu.tscn").instantiate()
	get_tree().current_scene.add_child(ui)
