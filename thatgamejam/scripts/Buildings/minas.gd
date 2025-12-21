extends Area2D

var total_construido = 0
const capacidade_maxima = 10
var custo_madeira = 10


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Clicou no Control")
