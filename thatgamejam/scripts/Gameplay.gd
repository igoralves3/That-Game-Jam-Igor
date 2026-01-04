extends Node2D

func _ready() -> void:
	Global.start_game()
	timer.start_game_time()
	EventsDatabase.load_events_to_manager()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Clicou em área vazia")
			
		var current = null
			
		if Global.currentBuildType == "Alojamento" and Global.wood >= 150:
			Global.wood = Global.wood- 150
			
			current = preload("res://prefabs/Buildings/Alojamento.tscn")
		elif Global.currentBuildType == "Minas" and Global.wood >= 200:
			Global.wood = Global.wood- 200
			
			current = preload("res://prefabs/Buildings/Minas.tscn")
		elif Global.currentBuildType == "Madeireira"and Global.wood >= 100:
			Global.wood = Global.wood- 100
			
			current = preload("res://prefabs/Buildings/Madeireira.tscn")
		elif Global.currentBuildType == "Capela":
			current = null#preload("res://prefabs/Buildings/Capela.tscn")
		elif Global.currentBuildType == "Fazenda" and Global.wood >= 150:
			Global.wood = Global.wood- 150
			
			current = preload("res://prefabs/Buildings/Fazenda.tscn")
			
		if current != null:
			var b = current.instantiate()
			b.global_position = get_global_mouse_position()
			add_child(b)
