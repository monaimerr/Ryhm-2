extends Node2D

func _ready() -> void:
	$DayProgressManager.time_updated.connect(_update_day_progress_display)
	$DayProgressManager.when_shop_opened()


func _update_day_progress_display(elapsed_seconds: int) -> void:
	var label = $CanvasLayer/DayProgressDisplay
	var newText = "Time of Day: %d" % (elapsed_seconds)
	label.text = newText
