extends Node
class_name EventManager

signal event_triggered(event: GameEvent)

@export var good_events: Array[GameEvent] = []
@export var bad_events: Array[GameEvent] = []

var pending_event: GameEvent = null
var pending_hour: int = -1
var event_triggered_today := false

func schedule_daily_event(day: int, week: int):
	event_triggered_today = false
	pending_event = null
	pending_hour = -1
	
	if good_events.is_empty() and bad_events.is_empty():
		return
	
	if randf() < 0.6:
		return
	
	var is_good = randf() < 0.5
	var pool = good_events if is_good else bad_events
	
	if pool.is_empty():
		return
	
	pending_event = pool.pick_random().duplicate(true)
	pending_hour = randi_range(6, 23)

func check_event_time(current_hour: int):
	if event_triggered_today:
		return
	
	if pending_event == null:
		return
	
	if current_hour >= pending_hour:
		trigger_event()

func trigger_event():
	if pending_event == null:
		return
	
	event_triggered_today = true
	emit_signal("event_triggered", pending_event)

func apply_event_option(option: EventOption):
	if option == null:
		return
	
	for key in option.effects.keys():
		var value = option.effects[key]
		Global.apply_effect(key, value)
	
	pending_event = null
	pending_hour = -1
