extends Node2D

@onready var interaction_component = $Area2D

var player_near = false

func _ready():
	if interaction_component == null:
		print("ERROR: Area2D node not found!")
		return
		
	var enter_result = interaction_component.body_entered.connect(_on_body_entered)
	var exit_result = interaction_component.body_exited.connect(_on_body_exited)
	
	if enter_result != OK or exit_result != OK:
		print("ERROR: Failed to connect signals!")
	else:
		print("Cauldron signals connected successfully")

func _on_body_entered(body):
	print("Body entered: ", body.name)
	if body.is_in_group("player"):
		player_near = true
		print("Press E to use the cauldron")

func _on_body_exited(body):
	print("Body exited: ", body.name)
	if body.is_in_group("player"):
		player_near = false
		print("Player left cauldron area")

func _process(delta):
	if player_near and Input.is_action_just_pressed("interact"):
		print("Interact key pressed")
		open_menu()

func open_menu():
	print("Opening potion crafting menu...")
	var ui = preload("res://scenes/UI/cauldron_menu/cauldronmenu.tscn").instantiate()
	get_tree().current_scene.add_child(ui)
