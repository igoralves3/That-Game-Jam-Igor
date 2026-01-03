extends Node

enum GameState {MENU, PLAYING, PAUSED}

var state := GameState.MENU

var producers := {}
var production_modifiers := {}

var total_followers: int = 0
var total_buildings: int = 0
var wood: int = 0
var faith: int = 0
var supplies: int = 0
var happiness: float = 1.0
var money: int = 0

var religionLvl: int = 1
var requirementsToLvlUp: Array[Dictionary] = [{"pop": 5}, {"pop": 10}, {"pop": 15}, {"pop": 25}, {"pop": 40}, {"pop":65}, {"pop": 105}, {"pop": 170}, {"pop": 275}, {"pop": 445}, {"pop": 720}, {"pop": 1000}]
var requirementIndex:= 0

@onready var prayTimer: Timer
var currentRitual: Ritual = null

var happinessLossBonus: float = 1.0
var happinessGainBonus: float = 1.0

var currentBuilding = null#"None"
var currentFollower = null

var currentBuildType = null

var currentCapela = null

func _ready():
	prayTimer = Timer.new()
	add_child(prayTimer)
	prayTimer.one_shot = true
	prayTimer.autostart = false
	prayTimer.timeout.connect(on_Pray_Over)

func start_game():
	state = GameState.PLAYING
	reset_game()

func reset_game():
	total_buildings = 0
	wood = 0
	faith = 0
	supplies = 0
	money = 0
	happiness = 1.0
	religionLvl = 1
	currentRitual = null

func pause_game():
	state = GameState.PAUSED
	timer.pause()

func resume_game():
	state = GameState.PLAYING
	timer.resume()

func end_game():
	state = GameState.MENU

func _process(delta: float) -> void:
	pass

func level_up() -> void:
	religionLvl+=1
	requirementIndex+=1
	print("[LvlUp] subiu de nível: ", religionLvl, " reqs: ", requirementsToLvlUp[requirementIndex])
	happinessGainBonus += 0.01

func check_level_up() -> bool:
	var requirement:Dictionary = requirementsToLvlUp[requirementIndex]
	for resourceKey in requirement:
		var resourceValue = requirement[resourceKey]
		var actualValue = getResource(resourceKey)
		if resourceValue > actualValue:
			return false
	return true

func getResource(resource: String) -> int:
	match (resource):
		"wood":
			return wood
		"supplies":
			return supplies
		"money":
			return money
		"faith":
			return faith
		"pop":
			return total_followers
		"total_followers":
			return total_followers
	return 0

func estimate_happiness() -> float:
	const max = 1.0
	const min = 0.0
	var lackOfSupply = 0.02 * happinessLossBonus
	var lackOfFaith = 0.01 * happinessLossBonus
	var supplydemandFufilled = 0.05 * happinessGainBonus
	var faithFufilled = 0.05 * happinessGainBonus
	var suppliesRequired: int = total_followers * 2
	var estimatedHappiness = happiness
	
	if suppliesRequired <= supplies:
		add_resource("supplies", -suppliesRequired)
		estimatedHappiness = clamp(estimatedHappiness + supplydemandFufilled, min, max)
		print("[Happy] Seguidores alimentados com sucesso + 5% ", estimatedHappiness)
	else: 
		var followersFed = floor(supplies/total_followers)
		var followersUnfed = total_followers - followersFed
		add_resource("supplies", -(followersFed*2))
		estimatedHappiness = clamp(estimatedHappiness - (lackOfSupply * followersUnfed), min, max)
		print("[Happy] Seguidores não alimentados ", followersUnfed, ", -2% por seguidor subnutrido ", estimatedHappiness)
	
	if timer.hasPrayed:
		estimatedHappiness = clamp(estimatedHappiness + faithFufilled, min, max)
		print("[Happy] Seguidores rezaram com sucesso + 5% ", estimatedHappiness)
	else:
		estimatedHappiness = clamp(estimatedHappiness - (lackOfFaith * total_followers), min, max)
		print("[Happy] Seguidores não rezaram ", estimatedHappiness)
		
	happiness = estimatedHappiness
	return estimatedHappiness
	
func add_resource(type: String, amount: int):
	if state != GameState.PLAYING:
		return
	match type:
		"wood":
			wood += amount
		"supplies":
			supplies += amount
		"money":
			money += amount
		"faith":
			faith += amount
	
	currentBuilding = null#"None"
	currentFollower = null

func apply_effect(effect_name: String, value) -> void:
	match effect_name: 
		"wood":
			wood = max(wood + int(value), 0)
		"supplies":
			supplies = max(supplies + int(value), 0)
		"money":
			money = max(money + int(value), 0)
		"faith":
			faith = max(faith + int(value), 0)
		"happiness":
			happiness = clamp(happiness + float(value), 0.0, 1.0)
		"total_followers":
			var current_followers = max(total_followers + int(value), 0)
			if current_followers < total_followers:
				removeFollower()

func can_apply_effects(effects: Dictionary) -> bool:
	for key in effects.keys():
		var value = effects[key]
		match key:
			"wood":
				if wood + value < 0:
					return false
			"supplies":
				if supplies + value < 0:
					return false
			"money":
				if money + value < 0:
					return false
			"faith":
				if faith + value < 0:
					return false
			"happines":
				if happiness + value < 0:
					return false
			"total_followers":
				if total_followers + value < 0:
					return false
	return true

func beginRitual(ritual:Ritual):
	print(ritual)
	currentRitual = ritual
	for cost in ritual.cost.keys():
		if cost != "pop" || cost!= "total_followers":
			add_resource(cost, ritual.cost[cost] * -1)
		else:
			removeFollower()
	prayTimer.wait_time = ritual.time
	prayTimer.start()

func on_Pray_Over():
	var rewardDic = currentRitual.reward
	for i in rewardDic.keys():
		apply_effect(i, rewardDic[i])
	timer.hasPrayed=true
	currentRitual = null
	print("[PRAY] wood: ", wood, ", supplies: ", supplies, ", faith: ", faith)

func removeFollower():
	var followerList = get_tree().get_nodes_in_group("Followers")
	var pickedFollower = followerList.pick_random()
	pickedFollower.queue_free()
	total_followers -=1

func salvar_jogo():
	var save_dict = {
		"status": {
		"money": money,
		"wood": wood,
		"faith": faith,
		"supplies": supplies,
		"religionLvl": religionLvl,
		"followers": total_followers,
		"week": timer.week,
		"day": timer.day,
		},
		"constructions": []
	}

	# Pega os dados de cada prédio no mapa
	var construcoes = get_tree().get_nodes_in_group("Constructions")
	for predio in construcoes:
		save_dict["constructions"].append(predio.get_save_data())

	# Escreve no disco (user:// é a pasta segura de save)
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save_dict)
	file.store_line(json_string)

func carregar_jogo():
	if not FileAccess.file_exists("user://savegame.save"):
		return

	var file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json_string = file.get_as_text()
	var data = JSON.parse_string(json_string)

	# 1. Carrega os valores globais
	var s = data["status"]
	money = s["money"]
	wood = s["wood"]
	faith = s["faith"]
	supplies = s["supplies"]
	religionLvl = s["religionLvl"]
	total_followers = s["followers"]
	timer.week = s["week"]
	timer.day = s["day"]
	# ... carregar os outros valores de tempo e recursos

	# 2. Limpa o mapa atual antes de recriar
	var predios_atuais = get_tree().get_nodes_in_group("Constructions")
	for p in predios_atuais:
		p.queue_free()

	# 3. Recria as construções
	for p_data in data["constructions"]:
		var nova_cena = load(p_data["filename"]).instantiate()
		get_tree().root.get_node("Node2D").add_child(nova_cena) # Ajuste o caminho se necessário
		nova_cena.global_position = Vector2(p_data["pos_x"], p_data["pos_y"])
		nova_cena.num_trabalhadores = p_data["trabalhadores"]

var active_temporal_effects: Array[TemporalEffect] = []

func add_temporal_effects(effect: TemporalEffect):
	var new_effect = effect.duplicate(true)
	new_effect.activate()
	active_temporal_effects.append(new_effect)

func tick_temporal_effects():
	var expired = []
	
	for effect in active_temporal_effects:
		if effect.tick_day():
			expired.append(effect)
	for effect in expired:
		active_temporal_effects.erase(effect)

func get_active_effects_description() -> String:
	if active_temporal_effects.is_empty():
		return ("No active effects")
	var text = "Active effects: \n"
	for effect in active_temporal_effects:
		text += "• %s (%d days)\n" % [effect.effect_name, effect.remaining_days]
	return text
