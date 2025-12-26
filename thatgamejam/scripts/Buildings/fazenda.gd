extends "res://scripts/Buildings/Building.gd"

const capacidade_maxima = 10

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Clicou na fazenda")
		
		Global.currentBuilding = self
		
		if Global.currentFollower != null:
			print('indo')
			
			Global.currentFollower.building = self
			
			Global.currentFollower.timer.stop()
			
			Global.currentFollower.agent.target_position = global_position
			Global.currentFollower.cur_state = Builder.SeguidorState.Working

func _ready():
	super()
