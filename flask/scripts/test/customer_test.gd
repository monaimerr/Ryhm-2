extends Node2D

@onready var path_2d: Path2D = $Path2D
@onready var customer_path_follow_scene = preload("res://scenes/entities/characters/NPCs/customer_path_follow.tscn")

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	

# Instanciates a new customer and adds it as path2D's child.
func _on_customer_spawn_timer_timeout() -> void:
	var instance = customer_path_follow_scene.instantiate()
	path_2d.add_child(instance)
