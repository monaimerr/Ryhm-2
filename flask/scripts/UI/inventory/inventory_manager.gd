extends Node

signal inventory_changed

var playerInv = Array()
@export var playerInvSize = 10

func _ready() -> void:
	pass

# Adds the item that is passed as argument.
# Returns true if the item was succesfully added and false otherwise
func add_item(item: Item):
	if playerInv.size() >= playerInvSize:
		return false
	playerInv.append(item)
	inventory_changed.emit()
	return true
	
# Removes an item from the player's inventory.
# Only removes one item at a time.
# Returns true if the item was succesfully removed and false otherwise.
func remove_item(item: Item):
	var i = playerInv.find(item)
	if i == -1:
		return false
	playerInv.remove_at(i)
	inventory_changed.emit()
	return true
