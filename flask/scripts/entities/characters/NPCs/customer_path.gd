extends Path2D

# Loads the scene that is required to spawn new customers
@onready var customer_path_follow_scene = preload("res://scenes/entities/characters/NPCs/customer_path_follow.tscn")
@export var max_customers = 3

# Instanciates a new customer if current customer count is less than max_customers
func _on_customer_spawn_timer_timeout() -> void:
	if get_child_count() < max_customers:
		var instance = customer_path_follow_scene.instantiate()
		add_child(instance)
		print(get_child_count())
		
