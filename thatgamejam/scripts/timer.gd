extends Node2D
enum Turno {Manha, Tarde, Noite}
const TURN_DURATION := {
	Turno.Manha: 10,#60.0,
	Turno.Tarde: 10,#180.0,
	Turno.Noite: 10#60.0
}
signal production_tick
signal day_changed(day, week)
signal pause_changed(paused)
signal speed_changed(speed)
@export var tick_interval := 10
var turnoAtual = Turno.Manha
var is_day := true
var ticking := false
var paused := false
var speed := 1.0
var day := 1
var week := 1

var elapsed_turn_time := 0.0
var current_turn_duration := 0.0
var day_changed_this_night := false

var hasPrayed: bool = false

@onready var gradientColor: Gradient = preload("res://scripts/dayAndNightCycle/day&night.tres")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	var follower_lst = get_tree().get_nodes_in_group("Followers")
	Global.total_followers = follower_lst.size()
	day_changed.connect(EventManagertscn.schedule_daily_event)

func start_game_time():
	if ticking:
		return
	ticking = true
	paused = false
	turnoAtual = Turno.Manha
	is_day = true
	current_turn_duration = TURN_DURATION[turnoAtual]
	elapsed_turn_time = 0.0
	day_changed_this_night = false
	_start_tick_loop()

func stop_game_time():
	ticking = false
	Engine.time_scale = 1.0

func pause():
	if paused:
		return
	paused = true
	get_tree().paused = true
	emit_signal("pause_changed", true)

func resume():
	if !paused:
		return
	paused = false
	get_tree().paused = false
	emit_signal("pause_changed", false)

func set_speed(multiplier: float):
	if multiplier <= 0:
		return
	
	speed = multiplier
	Engine.time_scale = speed
	emit_signal("speed_changed", speed)
	print("Speed changed to:", speed, " | time_scale:", Engine.time_scale)

func _process(delta: float) -> void:
	if !ticking or paused:
		return
	
	var previous_time = elapsed_turn_time
	
	elapsed_turn_time += delta
	
	var time := get_current_time()
	EventManagertscn.check_event_time(time.x)
	
	if turnoAtual == Turno.Noite and !day_changed_this_night:
		var progress_before = previous_time / current_turn_duration
		var progress_after = elapsed_turn_time / current_turn_duration
		var hour_before = progress_before * 6  
		var hour_after = progress_after * 6
		
		if hour_before < 0.1 and hour_after >= 0.1:
			day += 1
			if day > 7:
				day = 1
				week += 1
			emit_signal("day_changed", day, week)
			day_changed_this_night = true
			print("Novo dia:", day, "semana:", week)
	
	if elapsed_turn_time >= current_turn_duration:
		elapsed_turn_time = 0.0
		_change_turn()
		var follower_lst = get_tree().get_nodes_in_group("Followers")
		Global.total_followers = follower_lst.size()
		var canLvlUp:= Global.check_level_up()
		if canLvlUp:
			Global.level_up()

func get_day_progress() -> float:
	var total_duration = TURN_DURATION[Turno.Manha] + TURN_DURATION[Turno.Tarde] + TURN_DURATION[Turno.Noite]
	var accumulated_time = 0.0
	
	# Soma o tempo dos turnos que já passaram
	if turnoAtual == Turno.Tarde:
		accumulated_time += TURN_DURATION[Turno.Manha]
	elif turnoAtual == Turno.Noite:
		accumulated_time += TURN_DURATION[Turno.Manha] + TURN_DURATION[Turno.Tarde]
	# Soma o tempo decorrido no turno atual
	accumulated_time += elapsed_turn_time
	
	return accumulated_time / total_duration

func get_current_time() -> Vector2:
	if !ticking:
		return Vector2.ZERO
	
	var progress := elapsed_turn_time / current_turn_duration
	
	var start_hour := 0
	var duration_hours := 0
	
	match turnoAtual:
		Turno.Noite:
			start_hour = 0
			duration_hours = 6
		Turno.Manha:
			start_hour = 6
			duration_hours = 6
		Turno.Tarde:
			start_hour = 12
			duration_hours = 12
		
	var total_hours := start_hour + progress * duration_hours
	var hour := int(total_hours)
	var minutes := int((total_hours - hour) * 60)
	
	return Vector2(hour, minutes)

func _change_turn() -> void:
	if turnoAtual == Turno.Manha:
		turnoAtual = Turno.Tarde
		current_turn_duration = TURN_DURATION[turnoAtual]
		print('tarde')
	
	elif turnoAtual == Turno.Tarde:
		turnoAtual = Turno.Noite
		current_turn_duration = TURN_DURATION[turnoAtual]
		is_day = false
		day_changed_this_night = false  
		print('noite')
		
		for f in get_tree().get_nodes_in_group("Followers"):
			if f is Builder:
				if f.following == false:
					continue
				
				if f.cur_state == Builder.SeguidorState.Hidden:
					f.building.workers = f.building.workers - 1
				
				f.visible = true
				
				f.agent.target_position = f.global_position
				f.velocity = Vector2.ZERO
				f.timer.stop()
				f.cur_state = Builder.SeguidorState.Sleeping
				f.enter_sleeping()
	
	elif turnoAtual == Turno.Noite:
		turnoAtual = Turno.Manha
		Global.estimate_happiness()
		is_day = true
		hasPrayed = false
		current_turn_duration = TURN_DURATION[turnoAtual]
		print('manha')
		var follower_lst = get_tree().get_nodes_in_group("Followers")
		
		if Global.happiness < 0.5:
			var difference = 0.5 - Global.happiness
			var followers_quited = Global.total_followers * difference
			for i in range(followers_quited):
				var quitter = follower_lst.pick_random()
				quitter.queue_free()
			
		for f in follower_lst:
			if f is Builder:
				if f.following == false:
					continue
				if f.cur_state == Builder.SeguidorState.InsideAlojamento:
					f.alojamento.seguidores_alocados = f.alojamento.seguidores_alocados - 1
				
				f.visible = true
				if f.working:
					f.enter_working()
					"""
					if f.building != null:
						if f.building is Fazenda:
							f.cur_state = Builder.SeguidorState.Farmwork
						elif f.building is Minas:
							f.cur_state = Builder.SeguidorState.Minework
						elif f.building is Madeireira:
							f.cur_state = Builder.SeguidorState.Woodwork
						#f.cur_state = Builder.SeguidorState.Working
						f.agent.target_position = f.building.global_position
					"""
				else:
					f.working = true
					
					f.enter_working()#.enter_wander()
					
					#f.cur_state = Builder.SeguidorState.Working#Builder.SeguidorState.Wander
					
				
		var vagas = total_vagas()		
			
		
		for i in range(0,randi_range(1,vagas)):
			spawn_followers()

func _start_tick_loop():
	while ticking:
		await get_tree().create_timer(tick_interval, false).timeout
		if paused:
			continue
		if is_day:
			emit_signal("production_tick")
			Global.process_all_production()
			
func spawn_followers():
	if Global.happiness > 0.5:
		var nav_map :RID = get_world_2d().navigation_map
	
		var ponto := NavigationServer2D.map_get_random_point(
			nav_map,
			1,  # camada de navegação
			false
		)
		print("ponto: " + str(ponto))
		if ponto.x > get_viewport().get_visible_rect().size.x/2:
			ponto.x = 50
		else:
			ponto.x = get_viewport().get_visible_rect().size.x-50
	
	
		var agente := preload("res://prefabs/Builder.tscn").instantiate()
		agente.global_position = ponto
		
		agente.comecou_na_tela=false
		agente.cur_state = Builder.SeguidorState.Entering
		
		agente.visible=true
		add_child(agente)
		agente.add_to_group("Followers")

func total_vagas() -> int:
	var vagas = 0
	var alojamentos = get_tree().get_nodes_in_group("Alojamento")
	for a in alojamentos:
		if a is Alojamento:
			var alocados = a.max_seguidores-a.seguidores_alocados
			if alocados > 0:
				vagas = vagas + alocados
	return vagas

			
			
	
