## The code in this file is copied from, modified, or is otherwise based on the code in the following public repository:
##     https://github.com/QuebleGameDev/Godot---2D-Interaction
## Used with permission based on the following terms:
##     "Feel free to clone this repo, and/or use any of this code for whatever projects you'd like!"

extends Node2D

@onready var interact_label: Label = $InteractLabel
var current_interactions := []
var can_interact := true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if current_interactions:
			can_interact = false
			interact_label.hide()
			
			await current_interactions[0].interact.call()
			
			can_interact = true
	
	if event.is_action_pressed("alternative interact") and can_interact:
		if current_interactions:
			can_interact = false
			interact_label.hide()
			
			await current_interactions[0].interact2.call()
			
			can_interact = true
	
	if event.is_action_pressed("cycle") and can_interact:
		if current_interactions:
			can_interact = false
			interact_label.hide()
			
			await current_interactions[0].interact3.call()
			
			can_interact = true


func _process(_delta: float) -> void:
	if current_interactions and can_interact:
		current_interactions.sort_custom(_sort_by_nearest)
		if current_interactions[0].is_interactable:
			interact_label.text = current_interactions[0].interact_name
			interact_label.show()
	else:
		interact_label.hide()

func _sort_by_nearest(area1, area2):
	var area1_dist = global_position.direction_to(area1.global_position)
	var area2_dist = global_position.direction_to(area2.global_position)
	return area1_dist < area2_dist

func _on_interact_range_area_entered(area: Area2D) -> void:
	current_interactions.push_back(area)


func _on_interact_range_area_exited(area: Area2D) -> void:
	current_interactions.erase(area)
