extends Node
class_name specialPlantLight

export var light : PackedScene
export var lightSize : PoolRealArray = [0,0,0,0,0,0]
export var lightValue : PoolRealArray = [0,0,0,0,0,0]
export var glowTexture : Array = [Object(),Object(),Object(),Object(),Object(),Object()]
export var glowValue : PoolRealArray = [0,0,0,0,0,0]

func _process(delta):
	pass

func _ready():
	print("Fuck")
