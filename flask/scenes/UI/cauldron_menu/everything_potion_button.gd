extends Button

func _ready():
	var texture = preload("res://resources/items/potions/potion_of_everything.tres")
	var icon_rect = Rect2(50, 50, 64, 64)  # Adjust these values to crop your icon
	self.icon = texture.texture
