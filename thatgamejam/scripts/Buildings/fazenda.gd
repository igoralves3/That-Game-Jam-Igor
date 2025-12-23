extends "res://scripts/Buildings/Building.gd"

const capacidade_maxima = 10

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Clicou no Control")

func _ready():
	super()
