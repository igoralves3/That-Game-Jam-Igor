extends Area2D

class_name Alojamento

@export var total_construido = 1
@export var seguidores_alocados = 0
@export var max_seguidores = 3
@export var custo_madeira = 150

func get_save_data():
	return {
		"filename" : get_scene_file_path(), # Caminho da cena para recriar depois
		"pos_x" : global_position.x,
		"pos_y" : global_position.y,
	}
