extends Control

var cena = preload("res://CenaPrincipal.tscn")
var cenaOptions = preload("res://Options.tscn")


func _on_button_start_pressed() -> void:
	get_tree().change_scene_to_packed(cena)


func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_button_options_pressed() -> void:
	get_tree().change_scene_to_packed(cenaOptions)
