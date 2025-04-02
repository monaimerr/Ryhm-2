extends TextureRect

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("recipe"):
		visible = !visible
