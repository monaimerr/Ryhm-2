extends Node2D

@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@onready var customer: CharacterBody2D = $Path2D/PathFollow2D/Customer
@export var moveBy = 150
@onready var timer = $Path2D/PathFollow2D/Customer/WaitTimer
@onready var counter: Area2D = $Counter

func _ready() -> void:
	timer.timeout.connect(customer_timeout)
func _process(delta: float) -> void:
	if customer.canMove:
		move_customer(delta)
	
func move_customer(delta):
	path_follow_2d.progress += moveBy * delta
	
func customer_timeout():
	print("timeout")
