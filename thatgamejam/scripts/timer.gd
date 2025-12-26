extends Node2D

enum Turno {Manha, Tarde, Noite}

const TURN_DURATION := {
	Turno.Manha: 180.0 ,
	Turno.Tarde: 240.0,
	Turno.Noite: 180
}

signal production_tick
signal day_changed(day, week)
signal pause_changed(paused)

@export var tick_interval := 10

var turnoAtual = Turno.Manha;
var is_day := true

var timer: Timer
var ticking := false
var paused := false

var turn_duration := 180
var speed := 1

var day := 1
var week := 1



func _ready() -> void:
	timer = Timer.new()
	timer.ignore_time_scale = false
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func start_game_time():
	if ticking:
		return
	ticking = true
	paused = false
	_apply_timer()
	timer.start()
	_start_tick_loop()

func stop_game_time():
	ticking = false
	timer.stop()

func pause():
	if paused:
		return
	paused = true
	timer.paused = true
	emit_signal("pause_changed", true)

func resume():
	if !paused:
		return
	paused = false
	timer.paused = false
	emit_signal("pause_changed", false)

func set_speed(multiplier: float):
	if multiplier <= 0:
		return
	
	speed = multiplier
	emit_signal("speed_changed", speed)
	
	if timer.is_stopped() or paused:
		return
	
	var progress := 1.0 - (timer.time_left / timer.wait_time)
	_apply_timer()
	timer.start(timer.wait_time * (1.0 - progress))

func _apply_timer():
	timer.wait_time = turn_duration / speed

func _on_timer_timeout() -> void:
	print('timeout')
	
	
	
	if turnoAtual == Turno.Manha:
		turnoAtual = Turno.Tarde
		turn_duration = TURN_DURATION[turnoAtual]
		print('tarde')
	
	elif turnoAtual == Turno.Tarde:
		turnoAtual = Turno.Noite
		turn_duration = TURN_DURATION[turnoAtual]
		is_day = false
		print('noite')
	
	elif turnoAtual == Turno.Noite:
		turnoAtual = Turno.Manha
		is_day = true
		turn_duration = TURN_DURATION[turnoAtual]
		print('manha')
		
		for i in range(0,randi_range(1,5)):
			spawn_followers()
		
		
		day += 1
		if day > 7:
			day = 1
			week += 1
		
		emit_signal("day_changed", day, week)
	
	_apply_timer()
	timer.start()

func _start_tick_loop():
	while ticking:
		await get_tree().create_timer(tick_interval).timeout
		if is_day:
			emit_signal("production_tick")
			
func spawn_followers():
	var nav_map :RID = get_world_2d().navigation_map
	
	var ponto := NavigationServer2D.map_get_random_point(
		nav_map,
		1,  # camada de navegação
		false
	)
	print("ponto: " + str(ponto))
	
	var agente := preload("res://prefabs/Builder.tscn").instantiate()
	agente.global_position = ponto
	add_child(agente)
