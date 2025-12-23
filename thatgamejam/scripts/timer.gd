extends Node2D

enum Turno {Manha, Tarde, Noite}

var turnoAtual = Turno.Manha;
signal production_tick
@export var tick_interval := 10
var is_day := true
var timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.wait_time = 180
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	print('iniciou')
	start_tick()


	
func _physics_process(delta: float) -> void:
	print(str(timer.time_left))

func _on_timer_timeout() -> void:
	if turnoAtual == Turno.Manha:
		turnoAtual = Turno.Tarde
		timer.wait_time = 240
		print('tarde')
	
	elif turnoAtual == Turno.Tarde:
		turnoAtual = Turno.Noite
		timer.wait_time = 180
		is_day = false
		print('noite')
	elif turnoAtual == Turno.Noite:
		turnoAtual = Turno.Manha
		is_day = true
		timer.wait_time = 180
		print('manha')
		
	timer.start()

func start_tick():
	while true:
		await get_tree().create_timer(tick_interval).timeout
		if is_day:
			emit_signal("production_tick")
