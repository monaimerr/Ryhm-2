extends Node

signal inventory_changed

var playerInv = Array()
@export var playerInvSize = 10
@onready var item: Item = preload("res://resources/items/test_item.tres")

func _ready() -> void:
	add_item(item)

func add_item(item: Item):
	if playerInv.size() >= playerInvSize:
		return
	playerInv.append(item)
	inventory_changed.emit()
	
func remove_item(item: Item):
	var indexes = Array()
	
	for i in range(playerInv.size()):
		if playerInv[i] == item:
			indexes.append(i)
			
	indexes.sort()
	indexes.reverse()
	print(indexes)
	
	for i in indexes:
		playerInv.remove_at(i)
	
	inventory_changed.emit()
