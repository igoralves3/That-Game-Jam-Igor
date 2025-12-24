extends Control
enum Turno {Manha, Tarde, Noite}

var turnoAtual = Turno.Manha;

signal production_tick
@export var tick_interval := 10
var is_day := true

@onready var timer = $Timer
@onready var weekday = $BottomPanel/Controller/TimeController/MarginContainer/HBoxContainer/Weekday

var days;
var weeks

var base_time

var speed_up = false

func _ready():
	days = 1
	weeks = 1
	
	timer = Timer.new()
	timer.ignore_time_scale = false
	timer.paused = false
	timer.wait_time = 180
	base_time=timer.wait_time
	
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	print('iniciou')
	

func _on_menu_pressed() -> void:
	print("based")

func _process(delta: float) -> void:
	pass
	#print(str(timer.time_left))
	#if timer.paused: 
		#print(str(timer.paused))
	


func _on_pause_pressed() -> void:
	if timer.paused:
		timer.paused = false
		
	else: timer.paused = true


func _on_timer_timeout() -> void:
	if turnoAtual == Turno.Manha:
		turnoAtual = Turno.Tarde
		timer.wait_time = 4 #240
		
		base_time=timer.wait_time
		
		print('tarde')
	
	elif turnoAtual == Turno.Tarde:
		turnoAtual = Turno.Noite
		timer.wait_time = 2 #180
		
		base_time=timer.wait_time
		
		
		is_day = false
		print('noite')
	elif turnoAtual == Turno.Noite:
		turnoAtual = Turno.Manha
		is_day = true
		timer.wait_time = 2 #180
		
		base_time=timer.wait_time
		
		print('manha')
		
		days+=1
		if days > 7:
			days = 1
			weeks+=1
		
		weekday.text = "Week " + str(weeks) + ", day " + str(days)
	
	if speed_up:
			timer.wait_time = base_time / 2
	
	timer.start()


func _on_x_pressed() -> void:
	if speed_up == true:
		speed_up = false
		
		timer.paused = true
		print('1x')
		timer.wait_time=base_time
		timer.paused = false


func _on_2x_pressed() -> void:
	if speed_up == false:
		speed_up = true
		
		timer.paused = true
		print('2x')
		timer.wait_time=base_time/2
		timer.paused = false
