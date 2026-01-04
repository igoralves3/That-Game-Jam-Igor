extends PanelContainer

class_name ModalConversao

@export var correct_index := 0

@export var follower=null

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	correct_index = 0#randi() % 3


func open():
	Global.pause_game()
	visible = true
	
func close():
	Global.resume_game()
	visible = false

func _on_panel_container_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if correct_index == 0:
			follower.following = true
			follower.cur_state = Builder.SeguidorState.Wander
			follower.enter_wander()
			close()
		else:
			print('errou')
			follower.queue_free()
			close()


func _on_panel_container_2_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if correct_index == 1:
			follower.following = true
			follower.cur_state = Builder.SeguidorState.Wander
			follower.enter_wander()
			close()
		else:
			print('errou')
			follower.queue_free()
			close()


func _on_panel_container_3_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if correct_index == 2:
			follower.following = true
			follower.cur_state = Builder.SeguidorState.Wander
			follower.enter_wander()
			close()
		else:
			print('errou')
			follower.queue_free()
			close()
