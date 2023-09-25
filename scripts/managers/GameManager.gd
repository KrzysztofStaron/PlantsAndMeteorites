extends Node

export var canPause := true
export var day : int
var player : Player
export var money : int
export var ordered : Array
export var cloningStations : Array
export var overallBrightness : float
var time := 200.0
const dayLenght := 900.0 #900.0
var owners : PoolStringArray

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

func loadGame():
	var data : GameData = load("user://save_game.tres")
	if data == null:
		return
	else:
		var version : int = GameData.new().version
		print(version != data["version"])
		if version != data["version"]:
			return
	
	data = data.duplicate()
	for key in data.player:
		player[key] = data.player[key]
	
	var dropScene : PackedScene = preload("res://scenes/droppedItem.tscn")
	for item in data.itemsOnFloor:
		var dropNode : Node = dropScene.instance()
		dropNode.item = item[0]
		dropNode.position = item[1]
		get_node("/root/main/items").add_child(dropNode)
	
	print(data.inventory)
	for i in len(Inventory.inventory):
		if data.inventory[i] != null:
			Inventory.inventory[i] = data.inventory[i].duplicate()
		else:
			Inventory.inventory[i] = null

func saveGame():
	var save_data := GameData.new()
	save_data["player"] = player.getData()
	save_data["itemsOnFloor"] = get_node("../main/items").getData()
	save_data["inventory"] = Inventory.inventory
	print(Inventory.inventory)
	
	ResourceSaver.save("user://save_game.tres", save_data)
