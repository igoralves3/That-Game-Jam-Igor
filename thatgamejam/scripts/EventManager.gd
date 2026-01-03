extends Node
class_name EventManager

signal event_triggered(event: GameEvent)

@export var good_events: Array[GameEvent] = []
@export var bad_events: Array[GameEvent] = []

var pending_event: GameEvent = null
var pending_hour: int = -1
var event_triggered_today := false

func schedule_daily_event(day: int, week: int):
	print("método schedule chamado")
	event_triggered_today = false
	
	# checa se vai ter evento ou não
	if randf() < 0.2:
		print("Sem evento hoje")
		return
	
	var is_good = randf() < 0.5
	var pool = good_events if is_good else bad_events
	
	if pool.is_empty():
		return
	
	pending_event = pool.pick_random().duplicate(true)
	
	pending_hour = randi_range(0, 23)
	
	print ("Evento agendado: ", pending_event.title, "às ", pending_hour)

func check_event_time(current_hour: int):
	print("check_event_time | hora:", current_hour, "evento:", pending_hour)
	if event_triggered_today:
		return
	
	if pending_event == null:
		print("Evento nulo")
		return
	
	if current_hour >= pending_hour:
		print("Trigger no evento")
		trigger_event()
		
func trigger_event():
	event_triggered_today = true
	emit_signal("event_triggered", pending_event)
	
	pending_event = null
	pending_hour = -1

func apply_event_option(option: EventOption):
	for key in option.effects.keys():
		Global.apply_effect(key, option.effects[key])
	
	for temporal_effect in option.temporal_effects:
		Global.add_temporal_effects(temporal_effect)
	
	if option.duration_days > 0:
		var temp_effect = TemporalEffect.new()
		temp_effect.effect_name = "Event name"
		temp_effect.effects = option.effects.duplicate()
		temp_effect.duration_days = option.duration_days
		Global.add_temporal_effects(temp_effect)
