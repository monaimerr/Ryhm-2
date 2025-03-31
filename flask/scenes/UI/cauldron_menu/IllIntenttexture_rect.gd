extends TextureRect

func _ready():
	var texture = preload("res://resources/items/potions/potion_of_ill_intent.tres")
	var icon_rect = Rect2(50, 50, 64, 64)  # Adjust these values to crop your icon
	self.texture = texture.texture
	
