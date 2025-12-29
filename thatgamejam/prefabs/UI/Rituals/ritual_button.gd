extends PanelContainer

@onready var icone_rect = $MarginContainer/HBoxContainer/Icon
@onready var nome_label = $MarginContainer/HBoxContainer/VBoxContainer/Title

var ritual_info: Ritual

func setup(data: Ritual):
	ritual_info = data
	nome_label.text = data.title
	icone_rect.texture = data.icon
	
	if Global.religionLvl < data.level:
		modulate = Color(0.5, 0.5, 0.5) 

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		# Selecionado! Muda a cor do ícone como você pediu
		icone_rect.self_modulate = Color(1, 0.8, 0) # Dourado
		emit_signal("ritual_selecionado", ritual_info)

func _on_mouse_entered() -> void:
	# Aumenta o brilho (1.2) para dar o feedback de hover
	# Apenas se o nível for suficiente
	if Global.religionLvl >= ritual_info.level:
		modulate = Color(1.2, 1.2, 1.2) 

func _on_mouse_exited() -> void:
	# Retorna ao estado original
	if Global.religionLvl < ritual_info.level:
		modulate = Color(0.5, 0.5, 0.5) # Mantém cinza se estiver bloqueado
	else:
		modulate = Color(1, 1, 1) # Volta ao normal se estiver desbloqueado
