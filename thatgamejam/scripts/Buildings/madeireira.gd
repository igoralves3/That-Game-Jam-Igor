extends "res://scripts/Buildings/Building.gd"

class_name Madeireira

const capacidade_maxima = 10


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Clicou na madeireira")
		Global.currentBuilding = self
		
		if Global.currentFollower != null:
			print('indo')
			
			Global.currentFollower.building = self
			
			Global.currentFollower.timer.stop()
			
			Global.currentFollower.working = true
			
			Global.currentFollower.agent.target_position = global_position
			Global.currentFollower.cur_state = Builder.SeguidorState.Woodwork#Builder.SeguidorState.Working

func _process(delta):
	print("workes: ",workers)
	if workers > 0:
		$AnimationPlayer.play("active")
	else:
		$AnimationPlayer.stop()
		self.scale = Vector2(0.5, 0.5)

func get_save_data():
	return {
		"filename" : get_scene_file_path(), # Caminho da cena para recriar depois
		"pos_x" : global_position.x,
		"pos_y" : global_position.y,
	}

func _ready():
	if resource_type != "":
		Global.register_producer(self)

func _exit_tree():
	Global.unregister_producer(self)
