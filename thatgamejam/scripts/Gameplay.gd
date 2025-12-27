extends Node2D

func _ready() -> void:
	Global.start_game()
	timer.start_game_time()

func _unhandled_input(event: InputEvent) -> void:
	
	
	if event is InputEventMouseButton and event.pressed:
		print("Clicou em área vazia")
			
		var current = null
			
		if Global.currentBuildType == "Alojamento":
			current = preload("res://prefabs/Buildings/Alojamento.tscn")
		elif Global.currentBuildType == "Minas":
			current = preload("res://prefabs/Buildings/Minas.tscn")
		elif Global.currentBuildType == "Madeireira":
			current = preload("res://prefabs/Buildings/Madeireira.tscn")
		elif Global.currentBuildType == "Capela":
			current = preload("res://prefabs/Buildings/Capela.tscn")
		elif Global.currentBuildType == "Fazenda":
			current = preload("res://prefabs/Buildings/Fazenda.tscn")

		if current != null:
			var b = current.instantiate()
			b.global_position = get_global_mouse_position()
			add_child(b)
