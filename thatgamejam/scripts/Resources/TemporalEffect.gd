extends Resource
class_name TemporalEffect

@export var effect_name: String
@export var effects: Dictionary
@export var duration_days: int = 1
@export var description: String = ""

var remaining_days: int = 0
var is_active: bool = false

func activate():
	remaining_days = duration_days
	is_active = true
	_apply_effects()

func deactivate():
	is_active = false
	_apply_effects()

func tick_day():
	if not is_active:
		return
	
	remaining_days -= 1
	
	if remaining_days <= 0:
		deactivate()
		return true
	return false

func _apply_effects():
	for key in effects.keys():
		var value = effects[key]
		if key.ends_with("_production_modifier"):
			var resource_type = key.replace("_production_modifier", "")
			var current_modifier = Global.get_production_modifier(resource_type)
			Global.set_production_modifier(resource_type, current_modifier * value)
		elif key in ["wood", "supplies", "money", "faith", "happines"]:
			Global.apply_effect(key, value)
		elif key == "happiness_loss_modifier":
			Global.happinessLossBonus *= value
		elif key == "happiness_gain_modifier":
			Global.happinessGainBonus *= value

func _remove_effects():
	for key in effects.keys():
		if key.ends_with("_production_modifier"):
			var resource_type = key.replace("_production_modifier", "")
			var current_modifier = Global.get_production_modifier(resource_type)
			var value = effects[key]
			Global.set_production_modifier(resource_type, current_modifier / value)
		elif key == "happiness_loss_modifier":
			var value = effects[key]
			Global.happinessLossBonus /= value
		elif key == "happiness_gain_modifier":
			var value = effects[key]
			Global.happinessGainBonus /= value
