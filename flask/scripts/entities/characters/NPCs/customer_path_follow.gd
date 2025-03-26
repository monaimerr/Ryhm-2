extends PathFollow2D

@onready var customer: CharacterBody2D = $Customer
@export var moveBy = 150
@onready var timer = $Customer/WaitTimer
@onready var customerAnimatedSprite = $Customer/AnimatedSprite2D


func _ready() -> void:
	timer.timeout.connect(customer_timeout)
	
func _process(delta: float) -> void:
	if customer.canMove:
		customerAnimatedSprite.play()
		move_customer(delta)
	else:
		customerAnimatedSprite.stop()
	if progress_ratio >= 1:
		print("Customer deleted")
		queue_free()
	
func move_customer(delta):
	var old_y = global_position.y
	progress += moveBy * delta
	if global_position.y > old_y:
		customerAnimatedSprite.animation = "front"
	
	
func customer_timeout():
	print("timeout")


func _on_toggle_visibility_timeout() -> void:
	customer.visible = true
