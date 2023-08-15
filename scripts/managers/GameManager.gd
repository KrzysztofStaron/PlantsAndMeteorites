extends Node

export var canPause := true
export var day : int
var player : Player
export var money : int
export var ordered : Array
export var cloningStations : Array
export var overallBrightness : float

var time := 0.0
const dayLenght := 10.0 #900.0

var events := [
	[1, "test"],
	[1, "test2"]
]

func _process(delta):
	time += delta
	if time > dayLenght or Input.is_action_just_pressed("debug"):
		for tile in get_tree().get_nodes_in_group("crop_spot"):
			tile.nextDay()
			
		calcEvent()
		time = 0.0

	if Input.is_action_just_pressed("waterAll"):
		for tile in get_tree().get_nodes_in_group("crop_spot"):
			tile.water()

func calcEvent() -> void:
	for event in events:
		if randf() <= event[0]/100.0:
			add_child(load("res://scenes/events/" + event[1] + ".tscn").instance())
			break
