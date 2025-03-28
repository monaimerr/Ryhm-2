extends Node2D

@onready var steps = $steps

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_play_when_pressed()


func _play_when_pressed():
	
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	#if input_direction == Vector2.ZERO:
		# steps.play()
		# frame change to trigger audio?
		
	#else:
		#if input_direction != Vector2.ZERO:
			#steps.stop 


func _on_animated_sprite_2d_animation_looped() -> void:
	
	steps.set_pitch_scale(randf_range(0.8, 1.2))
	steps.play()
	
