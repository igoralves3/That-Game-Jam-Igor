extends Control

@export var lista_de_rituais: Array[Ritual] # Arraste seus arquivos .tres aqui
@export var ritual_button_prefab: PackedScene
@export var nivel_visibilidade: int = 5 # Quantos níveis à frente o ritual aparece
@export var ItemBoxObject: PackedScene

@onready var buttonContainer = $PanelContainer/VBoxContainer/MarginContainer/ScrollContainer/VBoxContainer

func _ready():
	atualizar_menu_rituais()

func abrir_modal():
	self.visible = true
	atualizar_menu_rituais() # Aquela função que criamos com o limpar_lista()

func fechar_modal():
	self.visible = false

func atualizar_menu_rituais():
	limpar_lista()
	
	for ritual in lista_de_rituais:
		# CONDIÇÃO: Só cria o botão se o nível do jogador for 
		# suficiente ou estiver perto do necessário.
		if Global.religionLvl >= (ritual.level - nivel_visibilidade):
			var novo_btn = ritual_button_prefab.instantiate()
			buttonContainer.add_child(novo_btn)
			novo_btn.ItemBoxObject = self.ItemBoxObject
			novo_btn.setup(ritual)
			novo_btn.connect("ritual_selecionado", on_selected_ritual, 0)

func on_selected_ritual(ritual: Ritual):
	if ritual.single:
		lista_de_rituais.erase(ritual)
	Global.beginRitual(ritual)
	fechar_modal()

func limpar_lista():
	for child in buttonContainer.get_children():
		child.queue_free()

func _on_capela_capela_clicada() -> void:
	abrir_modal()

func _on_texture_button_pressed():
	fechar_modal()
