extends PathFollow2D

@onready var customer: CharacterBody2D = $Customer
@export var moveBy = 150
@onready var timer = $Customer/WaitTimer


func _ready() -> void:
	timer.timeout.connect(customer_timeout)
	
func _process(delta: float) -> void:
	if customer.canMove:
		move_customer(delta)
	if progress_ratio >= 1:
		print("Customer deleted")
		queue_free()
	
func move_customer(delta):
	progress += moveBy * delta
	
func customer_timeout():
	print("timeout")


func _on_toggle_visibility_timeout() -> void:
	customer.visible = true
