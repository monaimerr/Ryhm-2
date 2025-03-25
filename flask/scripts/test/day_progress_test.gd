extends Node2D

func _ready() -> void:
	$DayProgressManager.time_advanced.connect(_update_day_progress_display)
	$DayProgressManager.start_day()


func _update_day_progress_display(time: float) -> void:
	var label = $CanvasLayer/DayProgressDisplay
	var newText = "Time of Day: %0.2f" % (time * $DayProgressManager.get_day_length())
	label.text = newText
