extends Control

@onready var weekday_label = $BottomPanel/Controller/TimeController/MarginContainer/HBoxContainer/Weekday
@onready var pause_button = $BottomPanel/Controller/TimeController/MarginContainer/HBoxContainer/Pause
@onready var speed_1x_button = $"BottomPanel/Controller/TimeController/MarginContainer/HBoxContainer/HBoxContainer/1x"
@onready var speed_2x_button = $"BottomPanel/Controller/TimeController/MarginContainer/HBoxContainer/HBoxContainer/2x"

func _ready():
	timer.day_changed.connect(_update_weekday)
	timer.pause_changed.connect(_update_pause_button)
	_update_speed_buttons(timer.speed)

func _on_pause_pressed():
	if timer.paused:
		Global.resume_game()
		timer.resume()
	else:
		Global.pause_game()
		timer.pause()

func _on_1x_pressed():
	timer.set_speed(1.0)

func _on_2x_pressed():
	timer.set_speed(2.0)

func _update_weekday(day, week):
	weekday_label.text = "Week %d, day %d" % [week, day]

func _update_pause_button(is_paused):
	pause_button.text = "Play" if is_paused else "Pause"

func _update_speed_buttons(current_speed):
	speed_1x_button.disabled = current_speed == 1.0
	speed_2x_button.disabled = current_speed == 2.0
