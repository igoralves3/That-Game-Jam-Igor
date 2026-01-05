extends Control

@onready var cena = preload("res://CenaPrincipal.tscn")

#var button_audio = preload("res://Assets/SFX/buttonSFX.ogg")

@onready var sfx = $AudioStreamPlayer2D

var current_action = 0

func _on_button_start_pressed() -> void:
	sfx.play()

	current_action=1

func _on_button_exit_pressed() -> void:
	sfx.play()
	current_action=3
	#get_tree().quit()

func _on_button_load_pressed():
	sfx.play()
	current_action=2

func _on_audio_stream_player_2d_finished() -> void:
	if current_action ==1:
		get_tree().change_scene_to_packed(cena)
	elif current_action==2:
		get_tree().change_scene_to_packed(cena)
		Global.carregar_jogo()
	elif current_action==3:
		get_tree().quit()
