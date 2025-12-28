extends Node

enum GameState {MENU, PLAYING, PAUSED}

var state := GameState.MENU

var total_followers: int = 0
var total_buildings: int = 0
var wood: int = 0
var faith: int = 0
var supplies: int = 0
var happiness: float = 1.0
var money: int = 0
var religionLvl: int = 1

var happinessLossBonus: float = 1.0
var happinessGainBonus: float = 1.0

var currentBuilding = null#"None"
var currentFollower = null

var currentBuildType = null

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

func pause_game():
	state = GameState.PAUSED

func resume_game():
	state = GameState.PLAYING

func end_game():
	state = GameState.MENU

func _process(delta: float) -> void:
	pass

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
