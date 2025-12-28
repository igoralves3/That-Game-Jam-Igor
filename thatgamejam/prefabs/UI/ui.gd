extends Control

@onready var weekday_label = $TopPanel/MarginContainer/TopTab/TimerController/Weekday
@onready var pause_button = $Controller/TimeController/MarginContainer/HBoxContainer/Pause
@onready var speed_1x_button = $"Controller/TimeController/MarginContainer/HBoxContainer/HBoxContainer/1x"
@onready var speed_2x_button = $"Controller/TimeController/MarginContainer/HBoxContainer/HBoxContainer/2x"

@onready var time_label = $TopPanel/MarginContainer/TopTab/TimerController/Time

@onready var wood_count_label = $TopPanel/MarginContainer/TopTab/GoldCounter/HBox/Label
@onready var supply_count_label = $TopPanel/MarginContainer/TopTab/SupplyCounter/HBox/Label
@onready var money_count_label = $TopPanel/MarginContainer/TopTab/GoldCounter/HBox/Label

@onready var pop_count_label = $TopPanel/MarginContainer/TopTab/Buttons/PopCounter/HBox/Label
@onready var happiness_count_label = $TopPanel/MarginContainer/TopTab/Buttons/HappinessCounter/HBox/Label
@onready var religion_lvl_label = $TopPanel/MarginContainer/TopTab/Buttons/ReligionLvl/HBox/Label

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	timer.day_changed.connect(_update_weekday)
	timer.pause_changed.connect(_update_pause_button)
	timer.speed_changed.connect(_update_speed_buttons)
	_update_speed_buttons(timer.speed)

func _process(delta: float) -> void:
	var time := timer.get_current_time()
	time_label.text = "%02d:%02d" % [int(time.x), int(time.y)]
	wood_count_label.text = str(Global.wood)
	money_count_label.text = str(Global.money)
	supply_count_label.text = str(Global.supplies)
	pop_count_label.text = str(Global.total_followers)
	happiness_count_label.text = str(Global.happiness)
	religion_lvl_label.text = str(Global.religionLvl)

func _on_pause_pressed():
	if timer.paused:
		Global.resume_game()
		timer.resume()
	else:
		Global.pause_game()
		timer.pause()

func _on_1x_pressed():
	if timer.paused:
		Global.resume_game()
		timer.resume()
	timer.set_speed(1.0)

func _on_2x_pressed():
	if timer.paused:
		Global.resume_game()
		timer.resume()
	timer.set_speed(2.0)


func _update_pause_button(is_paused):
	#pause_button.text = "Play" if is_paused else "Pause"
	pass

func _update_speed_buttons(current_speed):
	pass
	#speed_1x_button.disabled = current_speed == 1.0
	#speed_2x_button.disabled = current_speed == 2.0

func _update_weekday(day, week):
	weekday_label.text = "Week %d, day %d" % [week, day]


func _on_x_pressed():
	pass # Replace with function body.

#seleciona alojamento
func _on_texture_button_pressed() -> void:
	Global.currentBuildType = "Alojamento"

#seleciona minas
func _on_texture_button_2_pressed() -> void:
	Global.currentBuildType = "Minas"

#seleciona madeireira
func _on_texture_button_3_pressed() -> void:
	Global.currentBuildType = "Madeireira"

#seleciona capela
func _on_texture_button_4_pressed() -> void:
	Global.currentBuildType = "Capela"

#seleciona fazenda
func _on_texture_button_5_pressed() -> void:
	Global.currentBuildType = "Fazenda"
