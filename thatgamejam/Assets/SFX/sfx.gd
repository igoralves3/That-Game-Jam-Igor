extends Node

var button_audio = preload("res://Assets/SFX/buttonSFX.ogg")
var modal_close_sfx = preload("res://Assets/SFX/modalCloseSFX.ogg")
var modal_open_sfx = preload("res://Assets/SFX/modalOpenSFX.ogg")

@onready var sfx_modal_close = $SFXModalClose
@onready var sfx_modal_open = $SFXModalOpen

func _ready():
	sfx_modal_close.volume_db=  Global.sfx_volume
	sfx_modal_open.volume_db=  Global.sfx_volume

func play_open():
	sfx_modal_open.play()
	
func play_close():
	sfx_modal_close.play()
