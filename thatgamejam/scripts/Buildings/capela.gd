extends Area2D

class_name Capela

# Criamos o sinal para a UI escutar
signal capela_clicada

@export var total_construido = 1 # Começa com 1 construído [cite: 35, 89]

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if timer.paused:
			Global.resume_game()
			timer.resume()
		else:
			Global.pause_game()
			timer.pause()
		print("Clicou na capela")
		
		if !timer.hasPrayed:
			capela_clicada.emit()
			Global.currentCapela = self

func _process(delta):
	if Global.currentRitual != null:
		$AnimationPlayer.play("InSession")
	else:
		$AnimationPlayer.stop()
		self.scale = Vector2(1, 1)

func get_save_data():
	return {
		"filename" : get_scene_file_path(), # Caminho da cena para recriar depois
		"pos_x" : global_position.x,
		"pos_y" : global_position.y,
	}
