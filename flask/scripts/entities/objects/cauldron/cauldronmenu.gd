extends Control

func _ready():
	print("VBoxContainer: ", $VBoxContainer)
	print("HealthPotionButton: ", $VBoxContainer/HealthPotionButton)
	print("ManaPotionButton: ", $VBoxContainer/ManaPotionButton)
	print("CloseButton: ", $VBoxContainer/CloseButton)
	
	if $VBoxContainer/HealthPotionButton:
		$VBoxContainer/HealthPotionButton.pressed.connect(_on_potion_selected.bind("Health Potion"))
	else:
		print("ERROR: HealthPotionButton not found!")
	
	if $VBoxContainer/ManaPotionButton:
		$VBoxContainer/ManaPotionButton.pressed.connect(_on_potion_selected.bind("Mana Potion"))
	else:
		print("ERROR: ManaPotionButton not found!")
	
	if $VBoxContainer/CloseButton:
		$VBoxContainer/CloseButton.pressed.connect(queue_free)
	else:
		print("ERROR: CloseButton not found!")

func _on_potion_selected(potion_name):
	print(potion_name, " selected (no crafting logic yet)")
	#queue_free()
