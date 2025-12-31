extends Area2D

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
