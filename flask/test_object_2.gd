## The code in this file is copied from, modified, or is otherwise based on the code in the following public repository:
##     https://github.com/QuebleGameDev/Godot---2D-Interaction
## Used with permission based on the following terms:
##     "Feel free to clone this repo, and/or use any of this code for whatever projects you'd like!"

extends StaticBody2D

@onready var interactable: Area2D = $Interactable

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	print("You have opened the box!")
