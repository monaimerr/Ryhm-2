extends Node

signal time_advanced(day_progress: float)
signal day_over

@export var DAY_LENGTH_IN_SECONDS: int = 5
var elapsedSeconds: int = 0
@onready var secondTimer: Timer = $Timer

func _ready() -> void:
	secondTimer.timeout.connect(_second_timer_timeout)

func _reached_end_of_day() -> void:
	elapsedSeconds = DAY_LENGTH_IN_SECONDS
	secondTimer.stop()
	time_advanced.emit(get_day_progress())
	day_over.emit()

func _second_timer_timeout() -> void:
	elapsedSeconds += 1
	time_advanced.emit(get_day_progress())
	if elapsedSeconds >= DAY_LENGTH_IN_SECONDS:
		_reached_end_of_day()

func get_day_progress() -> float:
	return (elapsedSeconds as float) / DAY_LENGTH_IN_SECONDS

func is_day_over() -> bool:
	return elapsedSeconds >= DAY_LENGTH_IN_SECONDS

func get_day_length() -> int:
	return DAY_LENGTH_IN_SECONDS

func start_day() -> void:
	secondTimer.start(1)
	time_advanced.emit(0)

func end_day_early() -> void:
	if !is_day_over():
		_reached_end_of_day()
		
