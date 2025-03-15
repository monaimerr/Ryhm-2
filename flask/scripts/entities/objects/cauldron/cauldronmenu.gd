extends Control

func _ready():
	$VBoxContainer/HealthPotionButton.pressed.connect(_on_potion_selected.bind("Health Potion"))
	$VBoxContainer/ManaPotionButton.pressed.connect(_on_potion_selected.bind("Mana Potion"))
	$VBoxContainer/CloseButton.pressed.connect(queue_free)

func _on_potion_selected(potion_name):
	print(potion_name, "selected (no crafting logic yet)")
	queue_free()
