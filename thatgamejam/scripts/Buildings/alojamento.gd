extends Area2D

var total_construido = 1
const max_seguidores = 3
var custo_madeira = 50


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Clicou no Control")
		
