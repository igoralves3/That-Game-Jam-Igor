extends CharacterBody2D

class_name Builder

enum SeguidorState {Wander, Working, Sleeping, Praying, Hidden}

@export var cur_state = SeguidorState.Wander

@export var wander_radius := 100.0
@export var wander_speed := 20.0

@onready var agent = $NavigationAgent2D


var wander_target: Vector2

@onready var timer = $Timer

@export var building = null

func _ready():
	#await wait_for_navigation_ready()
	cur_state = SeguidorState.Wander
	enter_wander()
	

func wait_for_navigation_ready():
	while NavigationServer2D.map_get_iteration_id(
		$NavigationAgent2D.get_navigation_map()
	) == 0:
		await get_tree().physics_frame

func _physics_process(delta):
	if cur_state == SeguidorState.Wander:
		process_wander()
	elif cur_state == SeguidorState.Working:
		process_working()
	elif cur_state == SeguidorState.Hidden:
		process_hidden()

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
			if Global.currentFollower != self:
				Global.currentFollower = self;
				print(str(Global.currentFollower))
			else:
				Global.currentFollower = null

func process_working():
	print('working')
	if agent.is_navigation_finished() or global_position.distance_to(agent.target_position) < 5.0:
	
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
	print('hidden and visible = ' + str(visible))
