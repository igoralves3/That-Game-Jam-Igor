extends Control

@onready var title_label = $Panel/Title
@onready var desc_label = $Panel/Description
@onready var options_box = $Panel/Options
@onready var background = $Background

const OPTIONS_STYLEBOX := preload("res://prefabs/UI/Option_style.tres")
const OPTIONS_STYLEBOX_HOVER := preload("res://prefabs/UI/Option_style_hover.tres")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	visible = false
	
	var viewport_size = get_viewport_rect().size
	size = viewport_size
	position = Vector2.ZERO
	
	if background:
		background.size = viewport_size
		background.position = Vector2.ZERO
		background.mouse_filter = Control.MOUSE_FILTER_STOP
		background.color = Color(0, 0, 0, 0.5)

func show_event(event: GameEvent):
	title_label.text = event.title
	desc_label.text = event.description
	
	for child in options_box.get_children():
		child.queue_free()
		
	for option in event.options:
		var button = Button.new()
		button.text = option.text
		button.theme = OPTIONS_STYLEBOX
		
		button.add_theme_stylebox_override("normal", OPTIONS_STYLEBOX)
		button.add_theme_stylebox_override("hover", OPTIONS_STYLEBOX_HOVER)
		button.add_theme_stylebox_override("pressed", OPTIONS_STYLEBOX)
		button.add_theme_stylebox_override("focus", OPTIONS_STYLEBOX)
		
		button.pressed.connect(_on_option_selected.bind(option)) 
		options_box.add_child(button)
		
	visible = true
	Global.pause_game()

func _on_option_selected(option: EventOption):
	apply_effects(option.effects)
	
	Global.resume_game()
	queue_free()
	visible = false
	
func apply_effects(effects: Dictionary):
	for key in effects.keys():
		Global.apply_effect(key, effects[key])
