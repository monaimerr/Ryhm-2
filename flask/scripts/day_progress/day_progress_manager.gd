extends Node

signal time_updated(elapsed_seconds: int)
signal new_day_begun
signal shop_open_time_over

enum DayState {
	MORNING,
	SHOP_OPEN,
	EVENING,
}

var state: DayState;
@export var DAY_LENGTH_IN_SECONDS: int = 60
var elapsedSeconds: int = 0
@onready var secondTimer: Timer = $Timer

func _ready() -> void:
	_change_to_morning()
	secondTimer.timeout.connect(_second_timer_timeout)

func _set_time(newElapsedSeconds: int) -> void:
	elapsedSeconds = newElapsedSeconds
	time_updated.emit(newElapsedSeconds)

func _set_state(new_state: DayState) -> void:
	state = new_state

func _change_to_morning() -> void:
	state = DayState.MORNING
	new_day_begun.emit()
	secondTimer.stop()
	_set_time(0)

func _change_to_shop_open() -> void:
	state = DayState.SHOP_OPEN
	_set_time(0)
	secondTimer.start(1)
	
func _change_to_evening() -> void:
	state = DayState.EVENING
	shop_open_time_over.emit()
	secondTimer.stop()
	_set_time(DAY_LENGTH_IN_SECONDS)

func _second_timer_timeout() -> void:
	if state == DayState.SHOP_OPEN:
		_set_time(elapsedSeconds + 1)
		if elapsedSeconds >= DAY_LENGTH_IN_SECONDS:
			_change_to_evening()

func get_day_progress() -> float:
	return (elapsedSeconds as float) / DAY_LENGTH_IN_SECONDS

func get_day_length() -> int:
	return DAY_LENGTH_IN_SECONDS

func when_shop_opened() -> void:
	if state == DayState.MORNING:
		_change_to_shop_open()

func when_shop_closed_early() -> void:
	if state == DayState.SHOP_OPEN:
		_change_to_evening()
		
func start_new_day() -> void:
	_change_to_morning()
