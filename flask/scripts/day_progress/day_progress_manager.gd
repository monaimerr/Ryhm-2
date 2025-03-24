extends Node

signal time_advanced

var DAY_LENGTH_IN_SECONDS: float = 5.0
@onready var currentDayTimer: Timer = $Timer

func _ready() -> void:
	currentDayTimer.set_one_shot(true);
	currentDayTimer.timeout.connect(_reached_end_of_day)

func _process(_delta: float) -> void:
	time_advanced.emit(get_day_progress())

func _reached_end_of_day() -> void:
	pass

func get_day_progress() -> float:
	var remainingSeconds = DAY_LENGTH_IN_SECONDS - (currentDayTimer.time_left)
	return remainingSeconds / DAY_LENGTH_IN_SECONDS

func get_day_length() -> float:
	return DAY_LENGTH_IN_SECONDS
func start_day() -> void:
	currentDayTimer.start(DAY_LENGTH_IN_SECONDS)
