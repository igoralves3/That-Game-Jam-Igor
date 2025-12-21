extends Node

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

	currentBuilding = "None"
	currentFollower = null
