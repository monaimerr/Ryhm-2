extends CharacterBody2D

@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var spriteFrames: SpriteFrames
@export var canMove = true
@onready var wait_timer: Timer = $WaitTimer
@onready var collision_shape_2d: CollisionShape2D = $Blocked/CollisionShape2D
@onready var interaction_collision: CollisionShape2D = $Interactable/CollisionShape2D


func _ready() -> void:
	animated_sprite_2d.sprite_frames = spriteFrames
	interactable.interact = _on_interact
	interactable.is_interactable = false

func _on_interact():
	if (interactable.is_interactable):
		print("timer started")
		wait_timer.start()


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
	#canMove = false


func _on_area_2d_body_exited(body: Node2D) -> void:
	pass
	#canMove = true


func _on_area_2d_area_entered(area: Area2D) -> void:
	print("area entered")
	canMove = false
	interactable.is_interactable = true
	

func _on_area_2d_area_exited(area: Area2D) -> void:
	canMove = true


func _on_wait_timer_timeout() -> void:
	collision_shape_2d.disabled = true
	interactable.is_interactable = false
	interaction_collision.disabled = true
