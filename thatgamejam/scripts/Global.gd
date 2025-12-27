extends Node

enum GameState {MENU, PLAYING, PAUSED}

var state := GameState.MENU

var total_followers = 0
var total_buildings = 0
var wood = 0
var faith = 0
var supplies = 0
var money = 0

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

func pause_game():
	state = GameState.PAUSED

func resume_game():
	state = GameState.PLAYING

func end_game():
	state = GameState.MENU

func _process(delta: float) -> void:
	pass

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
