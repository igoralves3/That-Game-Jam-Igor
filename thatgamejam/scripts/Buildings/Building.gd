extends Area2D

@export var max_workers := 5
@export var workers := 0
@export var resource_type := ""
@export var production_per_worker := 1
@export var wood_cost := 0
@export var money_cost := 0
@export var supplies_cost := 0

func _ready():
	timer.production_tick.connect(_on_production_tick)
	Global.register_producer(self)

func _on_production_tick():
	pass

func _exit_tree():
	if timer.production_tick.is_connected(_on_production_tick):
		timer.production_tick.disconnect(_on_production_tick)
	Global.unregister_producer(self)
