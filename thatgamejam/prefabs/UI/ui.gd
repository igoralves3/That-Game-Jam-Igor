extends Control

@onready var weekday_label = $TopPanel/MarginContainer/TopTab/TimerController/Weekday
@onready var pause_button = $TopPanel/MarginContainer/TopTab/TimerController/Pause
@onready var speed_1x_button = $"TopPanel/MarginContainer/TopTab/TimerController/HBoxContainer/1x"
@onready var speed_2x_button = $"TopPanel/MarginContainer/TopTab/TimerController/HBoxContainer/2x"

@onready var time_label = $TopPanel/MarginContainer/TopTab/TimerController/Time

@onready var wood_count_label = $TopPanel/MarginContainer/TopTab/WoodCounter/HBox/Label
@onready var supply_count_label = $TopPanel/MarginContainer/TopTab/SupplyCounter/HBox/Label
@onready var money_count_label = $TopPanel/MarginContainer/TopTab/GoldCounter/HBox/Label

@onready var pop_count_label = $TopPanel/MarginContainer/TopTab/Buttons/PopCounter/HBox/Label
@onready var happiness_count_label = $TopPanel/MarginContainer/TopTab/Buttons/HappinessCounter/HBox/Label
@onready var religion_lvl_label = $TopPanel/MarginContainer/TopTab/Buttons/ReligionLvl/HBox/Label
@onready var faith_label = $TopPanel/MarginContainer/TopTab/FaithCounter/HBox/Label

@onready var wood_counter = $TopPanel/MarginContainer/TopTab/WoodCounter
@onready var supply_counter = $TopPanel/MarginContainer/TopTab/SupplyCounter
@onready var money_counter = $TopPanel/MarginContainer/TopTab/GoldCounter
@onready var faith_counter = $TopPanel/MarginContainer/TopTab/FaithCounter
@onready var pop_counter = $TopPanel/MarginContainer/TopTab/Buttons/PopCounter
@onready var religion_lvl_counter = $TopPanel/MarginContainer/TopTab/Buttons/ReligionLvl
@onready var happiness_counter = $TopPanel/MarginContainer/TopTab/Buttons/HappinessCounter

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	timer.day_changed.connect(_update_weekday)
	timer.pause_changed.connect(_update_pause_button)
	timer.speed_changed.connect(_update_speed_buttons)
	EventManagertscn.event_triggered.connect($EventModal.show_event)
	_update_speed_buttons(timer.speed)

func _process(delta: float) -> void:
	var time := timer.get_current_time()
	time_label.text = "%02d:%02d" % [int(time.x), int(time.y)]
	var wood_production = Global.calculate_total_production("wood")
	var supply_production = Global.calculate_total_production("supplies")
	var money_production = Global.calculate_total_production("money")
	
	if wood_production > 0:
		wood_count_label.text = "%d (+%d)" % [Global.wood, wood_production]
	else :
		wood_count_label.text = str(Global.wood)
		
	if supply_production > 0:
		supply_count_label.text = "%d (+%d)" % [Global.supplies, supply_production]
	else :
		supply_count_label.text = str(Global.supplies)
		
	if money_production > 0:
		money_count_label.text = "%d (+%d)" % [Global.money, money_production]
	else :
		money_count_label.text = str(Global.money)
	
	pop_count_label.text = str(Global.total_followers)
	happiness_count_label.text = "%.1f%%" % (Global.happiness * 100)
	religion_lvl_label.text = str(Global.religionLvl)
	faith_label.text = str(Global.faith)
	
	_update_tooltips()

func _update_tooltips():
	if wood_counter:
		wood_counter.tooltip_text = _generate_resource_tooltip("wood")
	
	if supply_counter:
		supply_counter.tooltip_text = _generate_resource_tooltip("supplies")
	
	if money_counter:
		money_counter.tooltip_text = _generate_resource_tooltip("money")
	
	if faith_counter:
		faith_counter.tooltip_text = _generate_tooltip("faith")
	
	if happiness_counter:
		happiness_counter.tooltip_text = _generate_tooltip("happiness")
	
	if religion_lvl_counter:
		religion_lvl_counter.tooltip_text = _generate_tooltip("religion_lvl")
	
	if pop_counter:
		pop_counter.tooltip_text = _generate_tooltip("pop")

func _generate_tooltip(counter_name: String) -> String:
	var name = ""
	var description = ""
	
	match counter_name:
		"faith":
			counter_name = "Faith"
			description = "Spiritual power of your religion \nUsed for upgrades"
		"happiness":
			counter_name = "Happiness"
			description = "General happiness of your followers \n Below 50%, followers start leaving"
		"religion_lvl":
			counter_name = "Religion Level"
			description = "Indicate how big is your religion"
		"pop":
			counter_name = "Followers"
			description = "Total number of followers"
		
	var tooltip = "%s\n%s\n" % [counter_name,description]
	return tooltip

func _generate_resource_tooltip(resource_type: String) -> String:
	var resource_name = ""
	var description = ""
	
	match resource_type:
		"wood":
			resource_name = "Wood"
			description = "Basic resource used for construction"
		"supplies":
			resource_name = "Supplies"
			description = "Used to feed your followers (2 per follower/day) and perform rituals"
		"money":
			resource_name = "Money"
			description = "Used for commerce and construction"
		
	var production = Global.calculate_total_production(resource_type)
	var modifier = Global.get_production_modifier(resource_type)
	var num_buildings = 0
	var active_buildings = 0
	
	if Global.producers.has(resource_type):
		num_buildings = Global.producers[resource_type].size()
		for building in Global.producers[resource_type]:
			if building.workers > 0:
				active_buildings += 1
	
	var tooltip = "%s\n%s\n" % [resource_name,description]
	
	if num_buildings > 0:
		tooltip += "\n"
		tooltip += "Production: +%d/tick\n" % production
		tooltip += "Buildings: %d (%d active)\n" % [num_buildings, active_buildings]
	
		if modifier != 1.0:
			var modifier_symbol = "+" if modifier > 1.0 else ""
			var modifier_percent = (modifier - 1) * 100
			tooltip += "Modifier: %s%.0f%%\n" % [modifier_symbol, modifier_percent]
	else :
		tooltip += "No active buildings"
	return tooltip
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
func _on_texture_button_pressed_alojamento() -> void:
	Global.currentBuildType = "Alojamento"

#seleciona minas
func _on_texture_button_pressed_minas() -> void:
	Global.currentBuildType = "Minas"

#seleciona madeireira
func _on_texture_button_pressed_madeireira() -> void:
	Global.currentBuildType = "Madeireira"

#seleciona capela
func _on_texture_button_pressed_capela() -> void:
	Global.currentBuildType = "Capela"

#seleciona fazenda
func _on_texture_button_pressed_fazenda() -> void:
	Global.currentBuildType = "Fazenda"
