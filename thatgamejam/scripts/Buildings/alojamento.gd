extends Area2D

@export var total_construido = 1
var seguidores_alocados = 0
@export var max_seguidores = 3
@export var custo_madeira = 150


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Clicou no Control")
		
