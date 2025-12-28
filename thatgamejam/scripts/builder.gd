extends CharacterBody2D

class_name Builder

enum SeguidorState {Entering, Stopped,Wander, 
Working, Woodwork, Minework, Farmwork, 
Sleeping, Praying, Hidden, InsideAlojamento}

@export var cur_state = SeguidorState.Wander

@export var wander_radius := 100.0
@export var wander_speed := 20.0

@onready var agent = $NavigationAgent2D


var wander_target: Vector2

@onready var timer = $Timer

@export var building = null

@export var working = false

@export var alojamento = null

func _ready():
	cur_state=SeguidorState.Entering
	#await wait_for_navigation_ready()
	#cur_state = SeguidorState.Wander
	#enter_wander()
	

func wait_for_navigation_ready():
	while NavigationServer2D.map_get_iteration_id(
		$NavigationAgent2D.get_navigation_map()
	) == 0:
		await get_tree().physics_frame

func _physics_process(delta):
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
			Global.currentFollower = self
			if cur_state == SeguidorState.Stopped:	
				cur_state = SeguidorState.Wander
				enter_wander()
				print(str(Global.currentFollower))
			#elif cur_state == SeguidorState.Wander:
				
			#else:
				
				
			#else:
			#	Global.currentFollower = null

func process_working():
	if building is Fazenda:
		print('working at farm')
	elif building is Minas:
		print('working at mines')
	elif building is Madeireira:
		print('working at wood')
	#print('working')
	if  global_position.distance_to(building.global_position) < 10.0:
	
		velocity = Vector2.ZERO
		#move_and_slide()
		
		
		cur_state = SeguidorState.Hidden
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
	
		velocity = Vector2.ZERO
		#move_and_slide()
		
		
		cur_state = SeguidorState.InsideAlojamento
		return
	
	var next_point = agent.get_next_path_position()
	var direction = (next_point - global_position).normalized()
	
	velocity = direction * wander_speed
	move_and_slide()
	
func enter_sleeping():
	
	var nearest = null
	var min_dist := INF
	
	for a in get_tree().get_nodes_in_group("Alojamento"):
		var dist = global_position.distance_to(a.global_position)
		if dist < min_dist:
			min_dist = dist
			nearest = a
			
			
	alojamento = nearest
	agent.target_position = nearest.global_position
	
func process_inside_alojamento():
	visible = false
	print('sleeping and visible = ' + str(visible))
	
func enter_inside_alojamento():
	pass


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	
	cur_state=SeguidorState.Stopped
	#enter_wander()
	

	
