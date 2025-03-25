extends Node2D

@onready var interactable: Area2D = $Interactable
var open = false
var opened_today = false
signal shop_opened_status_changed(shop_open: bool)

func _ready() -> void:
	interactable.interact = _on_interact
	
# opens the shop if the shop is currently closed adn hasn't yet been opened today
func _on_interact():
	if !open and !opened_today:
		open = true
		opened_today = true
	else:
		open = false
	shop_opened_status_changed.emit(open)
	print(open)
	
# should be called at the beginning of a new day to reset the state
func _on_day_changed():
	open = false
	opened_today = false
	
	
