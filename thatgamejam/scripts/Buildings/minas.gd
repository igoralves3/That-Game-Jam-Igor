extends "res://scripts/Buildings/Building.gd"

class_name Minas

const capacidade_maxima = 10
var currentWorkers = 0

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Clicou nas minas")
		
		Global.currentBuilding = self
		
		if Global.currentFollower != null:
			print('indo')
			
			Global.currentFollower.building = self
			
			Global.currentFollower.timer.stop()
			
			Global.currentFollower.working = true
			
			Global.currentFollower.agent.target_position = global_position
			Global.currentFollower.cur_state = Builder.SeguidorState.Minework#Builder.SeguidorState.Working

func get_save_data():
	return {
		"filename" : get_scene_file_path(), # Caminho da cena para recriar depois
		"pos_x" : global_position.x,
		"pos_y" : global_position.y,
	}
	
func _process(delta):
	if currentWorkers > 0:
		$AnimationPlayer.play("active")
	else:
		self.scale = Vector2(1, 1)

func _ready():
	if resource_type != "":
		Global.register_producer(self)

func _exit_tree():
	Global.unregister_producer(self)
