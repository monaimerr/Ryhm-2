extends AudioStreamPlayer

@onready var moneySound = $"."

func _ready() -> void:
	MoneyManager.player_money_changed.connect(_play_sound)

func _play_sound():
	moneySound.play()
