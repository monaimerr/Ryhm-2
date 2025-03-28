extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var ui_layer = get_node("/root/Main/UserInterfaceLayer")  # Assuming UI Layer is directly under Main
@onready var cauldron_menu = ui_layer.get_node("CauldronMenu")  # The CauldronMenu node

var player_near = false

func _ready() -> void:
	interactable.interact = _on_interact
	# Initially, the cauldron menu should be hidden
	cauldron_menu.visible = false

func _on_interact():
	open_menu()

func open_menu():
	print("Opening potion crafting menu...")

	if cauldron_menu:
		cauldron_menu.visible = true  # Show Cauldron Menu
		print("CauldronMenu is now visible.")
	else:
		print("Error: CauldronMenu not found.")
	cauldron_menu.visible = true
	ui_layer.move_child(cauldron_menu, ui_layer.get_child_count() - 1)  # Or use z_index
	print("CauldronMenu visible:", cauldron_menu.visible)
	print("CauldronMenu rect_position:", cauldron_menu.rect_position)
	print("CauldronMenu rect_size:", cauldron_menu.rect_size)
	
func close_menu():
	print("Closing potion crafting menu...")
	
	if cauldron_menu:
		cauldron_menu.visible = false  # Hide Cauldron Menu
		print("CauldronMenu hidden.")
	else:
		print("Error: CauldronMenu not found.")
