extends Node

signal player_money_changed
var amount = 0

func add_money(add: int) -> void:
	amount += add
	player_money_changed.emit()

# Attempts to remove money from the player.
# Returns true if succesfully removed and false if the player doesn't have enough money
func remove_money(remove: int):
	var temp = amount - remove
	if temp < 0:
		return false
	amount = temp
	player_money_changed.emit()
	return true
