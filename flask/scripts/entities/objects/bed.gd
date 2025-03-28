extends Node2D

@onready var interactable = $Interactable

signal sleeping

func _ready() -> void:
	interactable.interact_name = "Press [E] to sleep"
	interactable.interact = _interact

func _interact() -> void:
	sleeping.emit()
