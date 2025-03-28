## The code in this file is copied from, modified, or is otherwise based on the code in the following public repository:
##     https://github.com/QuebleGameDev/Godot---2D-Interaction
## Used with permission based on the following terms:
##     "Feel free to clone this repo, and/or use any of this code for whatever projects you'd like!"

extends Area2D

@export var interact_name: String = ""
@export var is_interactable: bool = true

var interact: Callable = func():
	pass

var interact2: Callable = func():
	pass

var interact3: Callable = func():
	pass
