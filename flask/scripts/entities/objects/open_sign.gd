extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var interactable: Area2D = $Interactable
var open = false
var opened_today = false
signal shop_opened_status_changed(shop_open: bool)

func _ready() -> void:
	interactable.interact = _on_interact
	
# opens the shop if the shop is currently closed adn hasn't yet been opened today
func _on_interact():
	if !open and !opened_today:
		open_shop()
	else:
		close_shop()
	print(open)
	
# should be called at the beginning of a new day to reset the state
func on_day_changed():
	opened_today = false
	interactable.interact_name = "[E] to open the shop"
	
func open_shop():
	open = true
	opened_today = true
	animated_sprite_2d.animation = "open"
	interactable.interact_name = "[E] to close the shop"
	shop_opened_status_changed.emit(open)
	
func close_shop():
	open = false
	animated_sprite_2d.animation = "closed"
	interactable.interact_name = "You can only open the shop once a day!"
	shop_opened_status_changed.emit(open)
	
	
	
