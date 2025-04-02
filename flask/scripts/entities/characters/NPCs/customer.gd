extends CharacterBody2D

@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var spriteFrames: SpriteFrames
@export var canMove = true
@export var potionRequest: PotionRequest
@onready var wait_timer: Timer = $WaitTimer
@onready var collision_shape_2d: CollisionShape2D = $Blocked/CollisionShape2D
@onready var interaction_collision: CollisionShape2D = $Interactable/CollisionShape2D
@onready var wait_time_progress_bar: ProgressBar = $WaitTimeProgressBar
@onready var speech_bubble: Sprite2D = $SpeechBubble
@onready var customer_collision: CollisionShape2D = $StaticBody2D/CustomerCollision


func _ready() -> void:
	animated_sprite_2d.sprite_frames = spriteFrames
	speech_bubble.texture = potionRequest.speechBubbleTexture
	interactable.interact = _on_interact
	interactable.interact2 = _on_interact2
	interactable.is_interactable = false

func _on_interact():
	if interactable.is_interactable:
		if InventoryManager.remove_item(potionRequest.potion):
			# Request completed
			MoneyManager.add_money(potionRequest.price)
			leave_shop()

func _on_interact2():
	if interactable.is_interactable:
		leave_shop()

# Updates the progressbar visual based on the remaining wait_timer time
func _physics_process(delta: float) -> void:
	if (!wait_timer.is_stopped()):
		wait_time_progress_bar.value = wait_timer.time_left / wait_timer.wait_time * 100


func _on_area_2d_area_entered(area: Area2D) -> void:
	# enables interaction if the Area2D is the counter (kassa)
	if area.get_collision_layer_value(4):
		interactable.is_interactable = true
		
	canMove = false
	speech_bubble.show()
	

func _on_area_2d_area_exited(area: Area2D) -> void:
	canMove = true
	

# Called when the wait timer runs out
# The timer running out means that the request was not fulfilled in time
func _on_wait_timer_timeout() -> void:
	leave_shop()
	
# Disables all collision, which makes the customer walk out of the shop
# Called when request is filled or the wait timer runs out
func leave_shop():
	speech_bubble.hide()
	collision_shape_2d.disabled = true
	interactable.is_interactable = false
	interaction_collision.disabled = true
	wait_time_progress_bar.hide()
