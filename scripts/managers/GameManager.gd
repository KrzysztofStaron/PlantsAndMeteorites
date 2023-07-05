extends Node

export var canPause := true
export var day : int
var player : Player
export var money : int
export var ordered : Array

func _process(delta):
	if Input.is_action_just_pressed("debug"):
		for tile in get_tree().get_nodes_in_group("crop_spot"):
			tile.nextDay()
			
	if Input.is_action_just_pressed("waterAll"):
		for tile in get_tree().get_nodes_in_group("crop_spot"):
			tile.watered  = true
