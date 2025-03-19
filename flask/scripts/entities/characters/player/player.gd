extends CharacterBody2D

@export var speed = 400
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	# Choosing the correct animation
	if input_direction.y != 0:
		if input_direction.y > 0:
			animated_sprite_2d.animation = "down"
		else:
			animated_sprite_2d.animation = "up"
	elif input_direction.x != 0:
		if input_direction.x > 0:
			animated_sprite_2d.animation = "right"
		else:
			animated_sprite_2d.animation = "left"
	

	# Animation is only played when the player is pressing a direction.
	if input_direction != Vector2.ZERO:
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.stop()
		

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	
