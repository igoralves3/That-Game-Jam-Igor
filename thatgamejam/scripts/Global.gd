extends Node

var total_followers = 0
var total_buildings = 0
var wood = 0
var faith = 0
var supplies = 0
var money = 0

var currentBuilding = "None"
var currentFollower = null

func reset_game():
	total_buildings = 0
	wood = 0
	faith = 0
	supplies = 0
	money = 0

func _process(delta: float) -> void:
	print("wood: "+ str(wood)+ " money: "+ str(money) +" supplies: "+ str(supplies))

func add_resource(type: String, amount: int):
	
	match type:
		"wood":
			wood += amount
		"supplies":
			supplies += amount
		"money":
			money += amount
		"faith":
			faith += amount

	currentBuilding = "None"
	currentFollower = null
