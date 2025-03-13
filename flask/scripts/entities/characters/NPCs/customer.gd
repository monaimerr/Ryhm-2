extends CharacterBody2D

@onready var interactable: Area2D = $Interactable
@export var canMove = true
@onready var wait_timer: Timer = $WaitTimer
@onready var collision_shape_2d: CollisionShape2D = $Blocked/CollisionShape2D


func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	print("timer started")
	wait_timer.start()


func _on_area_2d_body_entered(body: Node2D) -> void:
	canMove = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	canMove = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("area entered")
	canMove = false
	

func _on_area_2d_area_exited(area: Area2D) -> void:
	canMove = true


func _on_wait_timer_timeout() -> void:
	collision_shape_2d.disabled = true
