extends RichTextLabel

func _ready() -> void:
	MoneyManager.player_money_changed.connect(update_label)
	update_label()
	
func update_label():
	text = str(MoneyManager.amount)
