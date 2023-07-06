extends Node

export var canPause := true
export var day : int
var player : Player
export var money : int
export var ordered : Array

var events := [
	[50, "test"],
	[50, "test2"]
]

func _process(delta):
	if Input.is_action_just_pressed("debug"):
		for tile in get_tree().get_nodes_in_group("crop_spot"):
			tile.nextDay()
			
		calcEvent()
			
	if Input.is_action_just_pressed("waterAll"):
		for tile in get_tree().get_nodes_in_group("crop_spot"):
			tile.water()

func calcEvent() -> void:
	for event in events:
		if randf() < event[0]/100.0:
			add_child(load("res://scenes/events/" + event[1] + ".tscn").instance())
			break
