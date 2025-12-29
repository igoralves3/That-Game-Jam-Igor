extends Control

@export var lista_de_rituais: Array[Ritual] # Arraste seus arquivos .tres aqui
@export var ritual_button_prefab: PackedScene
@export var nivel_visibilidade: int = 5 # Quantos níveis à frente o ritual aparece

func _ready():
	atualizar_menu_rituais()
	

func abrir_modal():
	self.visible = true
	atualizar_menu_rituais() # Aquela função que criamos com o limpar_lista()

func atualizar_menu_rituais():
	limpar_lista()
	
	for ritual in lista_de_rituais:
		# CONDIÇÃO: Só cria o botão se o nível do jogador for 
		# suficiente ou estiver perto do necessário.
		if Global.religionLvl >= (ritual.level - nivel_visibilidade):
			var novo_btn = ritual_button_prefab.instantiate()
			$MarginContainer/HScrollBar/VBoxContainer.add_child(novo_btn)
			novo_btn.setup(ritual)

func limpar_lista():
	# Acessa o container onde os botões são injetados
	var container = $MarginContainer/HScrollBar/VBoxContainer
	
	# Remove todos os filhos existentes (placeholders do editor ou rituais antigos)
	for child in container.get_children():
		child.queue_free()


func _on_capela_capela_clicada() -> void:
	abrir_modal()


func _on_close_button_pressed() -> void:
	print("fechou clicado")
