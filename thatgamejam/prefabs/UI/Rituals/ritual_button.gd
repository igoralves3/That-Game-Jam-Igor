extends PanelContainer

@onready var icone_rect = $MarginContainer/HBoxContainer/Icon
@onready var nome_label = $MarginContainer/HBoxContainer/VBoxContainer/Title
@onready var CostContainer = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/CostContainer
@onready var RewardContainer = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/RewardContainer
var ItemBoxObject: PackedScene
var disabled: bool = false

var ritual_info: Ritual

signal ritual_selecionado(ritual:Ritual)

func setup(data: Ritual):
	ritual_info = data
	nome_label.text = data.title
	icone_rect.texture = data.icon
	
	if (Global.religionLvl < data.level) || !check_cost(data.cost):
		disabled = true
		modulate = Color(0.5, 0.5, 0.5)

	if data.cost.size() > 0:
		for cost in data.cost.keys():
			var novo_box = ItemBoxObject.instantiate()
			CostContainer.add_child(novo_box)
			novo_box.setup(cost, data.cost[cost])
	else:
		CostContainer.queue_free()
	
	if data.reward.size() > 0:
		for reward in data.reward.keys():
			var novo_box = ItemBoxObject.instantiate()
			RewardContainer.add_child(novo_box)
			novo_box.setup(reward, data.reward[reward])
	else:
		RewardContainer.queue_free()

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and !disabled:
		# Selecionado! Muda a cor do ícone como você pediu
		icone_rect.self_modulate = Color("#7f7f7f") # Dourado
		emit_signal("ritual_selecionado", ritual_info)
		
		#acrescentado por igor
		timer.resume()
		followers_go_to_capela()

func _on_mouse_entered() -> void:
	# Aumenta o brilho (1.2) para dar o feedback de hover
	# Apenas se o nível for suficiente
	if Global.religionLvl >= ritual_info.level and !disabled:
		modulate = Color("#7f7f7f")

func _on_mouse_exited() -> void:
	if !disabled:
	# Retorna ao estado original
		if Global.religionLvl < ritual_info.level:
			modulate = Color(0.5, 0.5, 0.5) # Mantém cinza se estiver bloqueado
		else:
			modulate = Color(1, 1, 1) # Volta ao normal se estiver desbloqueado

func check_cost(data: Dictionary) -> bool:
	for cost in data.keys():
		var playersResource:= Global.getResource(cost)
		if data[cost] > playersResource:
			return false
	return true
	
func followers_go_to_capela():
	var followers =  get_tree().get_nodes_in_group("Followers")
	for f in followers:
		
			print(str(f))
			f.enter_praying()
