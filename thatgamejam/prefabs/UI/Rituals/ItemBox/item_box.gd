extends HBoxContainer

@onready var icon = $TextureRect
@onready var label = $Label

func setup(key: String, value: float):
	icon.texture = iconAssignment(key)
	label.text = str(value)

func iconAssignment(key: String) -> Texture2D:
	match key:
		"wood":
			return preload("res://Assets/Icons/logs.png")
		"supplies":
			return preload("res://Assets/Icons/foods.png")
		"money":
			return preload("res://Assets/Icons/gold_ingots.png")
		"faith":
			return preload("res://Assets/UI Components/KEY ICONS/clean ui_key icon-06.png")
		"happiness":
			return preload("res://Assets/Icons/beer_mug.png")
		"total_followers":
			return preload("res://Assets/Icons/beer_mug.png")
	return null
