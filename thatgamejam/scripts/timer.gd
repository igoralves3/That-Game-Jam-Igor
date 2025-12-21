extends Node2D

enum Turno {Manha, Tarde, Noite}

var turnoAtual;

@onready var timer = $Timer

func _ready() -> void:
	turnoAtual = Turno.Manha
	

	
	


func _on_timer_timeout() -> void:
	if turnoAtual == Turno.Manha:
		turnoAtual = Turno.Tarde
		timer.wait_time = 240
		print('tarde')
	
	elif turnoAtual == Turno.Tarde:
		turnoAtual = Turno.Noite
		timer.wait_time = 180
		print('noite')
	elif turnoAtual == Turno.Noite:
		turnoAtual = Turno.Manha
		timer.wait_time = 180
		print('manha')
		
	timer.start()
