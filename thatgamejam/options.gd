extends Control
var cenaMenu ="res://MenuPrincipal.tscn"

@onready var music_bus = AudioServer.get_bus_index("Music")
@onready var sfx_bus = AudioServer.get_bus_index("SFX")

func _ready():
	load_volume()

func _on_button_pressed() -> void:
	save_volume($MusicSlider.value, $SFXSlider.value)
	get_tree().change_scene_to_file(cenaMenu)


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))


func _on_h_slider_2_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))

func save_volume(value_music, value_sfx):
	var config = ConfigFile.new()
	config.set_value("audio", "music", value_music)
	config.set_value("audio", "sfx", value_sfx)
	config.save("user://settings.cfg")

func load_volume():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		$MusicSlider.value = config.get_value("audio", "music", 1.0)
		$SFXSlider.value = config.get_value("audio", "sfx", 1.0)
