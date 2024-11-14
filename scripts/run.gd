extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	gui_process()

func gui_process():
	var time = $Game.time
	# print(time)

	$Gui/Score.text = ("%010d"%($Game.score))
	$Gui/SPS.text = ("%05.3f/s"%($Game.score/maxf(0.00001, time)))

	var _time = int(time)

	var _hour = _time/3600
	var _min = _time%3600/60
	var _sec = _time%60/1

	$Gui/Time.text = ("%02d:%02d:%02d"%[_hour, _min, _sec])

	var health = $Game/Player.health
	var mana = $Game/Player.mana

	$Gui/Panel/SplitContainer/HealthBar.max_value = $Game/Player.max_health
	$Gui/Panel/SplitContainer/ManaBar.max_value = $Game/Player.max_mana

	$Gui/Panel/SplitContainer/HealthBar.value = health
	$Gui/Panel/SplitContainer/ManaBar.value = mana

	$Gui/Panel/SplitContainer/HealthBar/Value.text = String.num_int64(health)
	$Gui/Panel/SplitContainer/ManaBar/Value.text = String.num_int64(mana)

	$Gui/CastleHealth.text = String.num_int64($Game.castle_health)