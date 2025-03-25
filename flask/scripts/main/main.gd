extends Node

func _ready() -> void:
	$DayProgressManager.day_over.connect($game_level/OpenSign.close_shop)
	$game_level/OpenSign.shop_opened_status_changed.connect(_shop_opened_or_closed)

func _shop_opened_or_closed(open: bool) -> void:
	if open:
		$DayProgressManager.start_day()
	else:
		$DayProgressManager.end_day_early()
