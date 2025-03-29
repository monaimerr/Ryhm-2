extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var ui_layer = get_node("/root/Main/UserInterfaceLayer")  # Assuming UI Layer is directly under Main
@onready var cauldron_menu = ui_layer.get_node("CauldronMenu")  # The CauldronMenu node

var player_near = false

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	open_menu()

func open_menu():
	#debug print to see if interaction works
	print("Opening potion crafting menu...")
	#print if cauldronmenu is not loading
	if !cauldron_menu:
		print("Error: CauldronMenu not found.")
	#not sure why but this line is required for the menu to show up on interact
	cauldron_menu.visible = true
	
	ui_layer.move_child(cauldron_menu, ui_layer.get_child_count() - 1)  # Or use z_index
	#debug prints, can be deleted in final version
	print("CauldronMenu visible:", cauldron_menu.visible)
	print("CauldronMenu position:", cauldron_menu.position)
	print("CauldronMenu size:", cauldron_menu.size)

	
func close_menu():
	print("Closing potion crafting menu...")
