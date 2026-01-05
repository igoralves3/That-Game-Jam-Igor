extends Control
class_name ModalConversao

@onready var title = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/Title
@onready var humanBtn = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/Human
@onready var religiousBtn = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/Religious
@onready var rationalBtn = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/Rational
@onready var refusalBtn = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/VBoxContainer/Refusal

@export var correct_index := 0

@export var follower=null
var dilema:Story

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	correct_index = 0#randi() % 3


func open():
	
	Global.pause_game()
	
	visible = true
	setup()
	
	SFXManager.play_open()
	
func close():
	Global.resume_game()
	
	Global.play_close_modal_sfx()
	
	visible = false
	

func setup():
	correct_index = dilema.answer
	title.text = dilema.story
	humanBtn.text = dilema.answerHuman
	religiousBtn.text = dilema.answerReligious
	rationalBtn.text = dilema.answerRational
	refusalBtn.text = dilema.answerCurse

func checkChoice(index: int) -> void:
	if correct_index == index:
		follower.following = true
		follower.cur_state = Builder.SeguidorState.Wander
		follower.enter_wander()
		close()
	else:
		follower.queue_free()
		close()

func _on_human_pressed():
	checkChoice(0)

func _on_religious_pressed():
	checkChoice(1)

func _on_rational_pressed():
	checkChoice(2)

func _on_refusal_pressed():
	follower.queue_free()
