extends CharacterBody2D

class_name Builder

enum SeguidorState {Entering, Stopped,Wander, 
Working, Woodwork, Minework, Farmwork, 
Sleeping, Praying, Hidden, InsideAlojamento,
GoPraying}

@export var cur_state = SeguidorState.Entering

@export var wander_radius := 100.0
@export var wander_speed := 60.0

@onready var agent = $NavigationAgent2D


var wander_target: Vector2

@onready var timer = $Timer
@onready var sprite = $Sprite2D

@export var building = null

@export var working = false

@export var alojamento = null
@export var capela = null

@export var dialogo = null

@export var comecou_na_tela = true
@export var following = false

var color: String
var possibleColors = ["BLACK", "BLUE", "PURPLE", "RED", "YELLOW"]


func _ready():
	velocity = Vector2.ZERO 
	dialogo = get_tree().get_first_node_in_group("Canvas")
	color = possibleColors.pick_random()
	
	
		

func animation_controller():
	var anim_name = ""
	var state_suffix = "idle"
	var tool_suffix = ""

	if velocity.length() > 0:
		print(velocity.length())
		state_suffix = "run"
	else:
		state_suffix = "idle"

	match cur_state:
		SeguidorState.Minework:
			tool_suffix = "_pickaxe"
		SeguidorState.Woodwork:
			tool_suffix = "_axe"
		SeguidorState.Farmwork:
			tool_suffix = "_knife"

	if state_suffix == "idle":
		anim_name = color.to_lower() + "_" + state_suffix
	else:
		anim_name = color.to_lower() + "_" + state_suffix + tool_suffix

	if sprite.sprite_frames.has_animation(anim_name):
		sprite.play(anim_name)
		print("[ANIM] ", anim_name)
	else:
		print("[ERRO] NÃO EXISTE: ", anim_name)
	
	if velocity.x != 0:
		sprite.flip_h = velocity.x < 0

func wait_for_navigation_ready():
	while NavigationServer2D.map_get_iteration_id(
		$NavigationAgent2D.get_navigation_map()
	) == 0:
		await get_tree().physics_frame

func _physics_process(delta):
	print("[ESTADO] ",cur_state)
	if cur_state == SeguidorState.Entering:
		process_entering()
	elif cur_state == SeguidorState.Wander:
		process_wander()
	elif cur_state == SeguidorState.Working:
		process_working()
	elif  cur_state == SeguidorState.Woodwork:
		process_working()
	elif  cur_state == SeguidorState.Minework:
		process_working()
	elif  cur_state == SeguidorState.Farmwork:
		process_working()
	elif cur_state == SeguidorState.Hidden:
		process_hidden()
	elif cur_state == SeguidorState.Sleeping:
		process_sleeping()
	elif cur_state == SeguidorState.InsideAlojamento:
		process_inside_alojamento()
	elif cur_state == SeguidorState.GoPraying:
		process_go_praying()
	elif cur_state == SeguidorState.Praying:
		process_praying()
	
	animation_controller()

func process_entering():
	if global_position.x > get_viewport().get_visible_rect().size.x/2:
		velocity.x = -50
		
	else:
		velocity.x = 50
	move_and_slide()

func process_wander():
	

	var next_position = agent.get_next_path_position()
	var direction = (next_position - global_position).normalized()

	velocity.x = direction.x * wander_speed
	velocity.y = direction.y * wander_speed
	
	move_and_slide()

func get_random_wander_point() -> Vector2:
	var random_direction = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()

	
	
	var global2d = Vector2(global_position.x,global_position.y);

	var random_point = global2d + random_direction * randf_range(10.0, wander_radius)

	return NavigationServer2D.map_get_closest_point(
		agent.get_navigation_map(),
		random_point
	)
	
func enter_wander():
	wander_target = get_random_wander_point()
	print(wander_target)
	agent.target_position = wander_target
	
	timer.wait_time = randi_range(1,10)
	timer.start()
	

func _on_timer_timeout() -> void:
	enter_wander()
	


func _on_navigation_agent_2d_navigation_finished() -> void:
	enter_wander()


#func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
#	if event is InputEventMouseButton:
#		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
#			print("Clicou no personagem!")


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#if Global.currentFollower != self 
			
			if cur_state == SeguidorState.Stopped:	
				Global.currentFollower = self
				open_dialog()
				
				#cur_state = SeguidorState.Wander
				#enter_wander()
				#print(str(Global.currentFollower))
			
			
			#elif cur_state == SeguidorState.Wander:
				
			#else:
				
				
			#else:
			#	Global.currentFollower = null

func enter_working():
	timer.stop()
	if alojamento != null:
		if alojamento.seguidores_alocados > 0:
			alojamento.seguidores_alocados = alojamento.seguidores_alocados - 1
		alojamento = null
		
	
	var nearest = null
	var min_dist := INF
	
	for c in get_tree().get_nodes_in_group("Constructions"):
		if c is Fazenda or c is Madeireira or c is Minas:
			if c.workers < c.max_workers:		
				var dist = global_position.distance_to(c.global_position)
				if dist < min_dist:
					min_dist = dist
					nearest = c
			
	if nearest == null:
		queue_free()		
	
	building = nearest
	agent.target_position = nearest.global_position
	
	if building is Fazenda:
						
		cur_state = Builder.SeguidorState.Farmwork
	elif building is Minas:
						
		cur_state = Builder.SeguidorState.Minework
	elif building is Madeireira:
						
		cur_state = Builder.SeguidorState.Woodwork

func process_working():
	if building is Fazenda:
		print('working at farm')
	elif building is Minas:
		print('working at mines')
	elif building is Madeireira:
		print('working at wood')
	#print('working')
	if  global_position.distance_to(building.global_position) < 10.0:
	
		if building.workers < building.max_workers:
			building.workers = building.workers + 1
	
			velocity = Vector2.ZERO
			#move_and_slide()
		
		
			cur_state = SeguidorState.Hidden
			
			return
		
		enter_working()
		return
	
	var next_point = agent.get_next_path_position()
	var direction = (next_point - global_position).normalized()
	
	velocity = direction * wander_speed
	move_and_slide()

func process_hidden():
	visible = false
	print('working and visible = ' + str(visible))
	
func process_sleeping():
	print(str(self) + ' is sleeping')
	
	if  global_position.distance_to(alojamento.global_position) < 10.0:
		if alojamento.max_seguidores > alojamento.seguidores_alocados:
			alojamento.seguidores_alocados = alojamento.seguidores_alocados + 1
			velocity = Vector2.ZERO
			#move_and_slide()
		
			
			cur_state = SeguidorState.InsideAlojamento
			return
		enter_sleeping()
		return
	
	var next_point = agent.get_next_path_position()
	var direction = (next_point - global_position).normalized()
	
	velocity = direction * wander_speed
	move_and_slide()
	
func enter_sleeping():
	timer.stop()
	if building != null:
		if building.workers > 0:
			building.workers = building.workers- 1
		building = null
	
	var nearest = null
	var min_dist := INF
	
	for a in get_tree().get_nodes_in_group("Alojamento"):
		if a is Alojamento:
			if a.seguidores_alocados < a.max_seguidores:		
				var dist = global_position.distance_to(a.global_position)
				if dist < min_dist:
					min_dist = dist
					nearest = a
			
	if nearest == null:
		queue_free()		
	
	alojamento = nearest
	agent.target_position = nearest.global_position
	
func process_inside_alojamento():
	visible = false
	print('sleeping and visible = ' + str(visible))
	
func enter_inside_alojamento():
	pass


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if comecou_na_tela == false:
		comecou_na_tela=true	
		cur_state=SeguidorState.Stopped
	else:
		if following == false: 
			following = true
			cur_state=SeguidorState.Wander
			enter_wander()
	

func enter_praying():
	cur_state = SeguidorState.GoPraying
	capela = Global.currentCapela
	agent.target_position = capela.global_position
	
	
func process_go_praying():
	print('going to capela ' + str(capela))
	
	if  global_position.distance_to(capela.global_position) < 20.0:
	
		velocity = Vector2.ZERO
		#move_and_slide()
		
		
		cur_state = SeguidorState.Praying
		return
	
	var next_point = agent.get_next_path_position()
	var direction = (next_point - global_position).normalized()
	
	velocity = direction * 10.0
	move_and_slide()
	
func process_praying():
	visible = false
	print('praying at ' + str(capela))
	
func open_dialog():
	dialogo.follower = self
	dialogo.open()
