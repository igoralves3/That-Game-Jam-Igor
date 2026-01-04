extends Control

var cena = preload("res://CenaPrincipal.tscn")
var cenaOptions = preload("res://Options.tscn")

#var button_audio = preload("res://Assets/SFX/buttonSFX.ogg")

@onready var sfx = $AudioStreamPlayer2D

var current_action = 0

func _on_button_start_pressed() -> void:
	sfx.play()

	current_action=1
	#get_tree().change_scene_to_packed(cena)


func _on_button_exit_pressed() -> void:
	sfx.play()
	current_action=3
	#get_tree().quit()


func _on_button_options_pressed() -> void:
	sfx.play()
	current_action=2
	#get_tree().change_scene_to_packed(cenaOptions)


func _on_audio_stream_player_2d_finished() -> void:
	if current_action ==1:
		get_tree().change_scene_to_packed(cena)
	elif current_action==2:
		get_tree().change_scene_to_packed(cenaOptions)
	elif current_action==3:
		get_tree().quit()
