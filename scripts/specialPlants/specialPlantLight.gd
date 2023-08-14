extends Node2D

export var lightSize : PoolRealArray = [0,0,0,0,0,0]
export var lightEnergy : PoolRealArray = [0,0,0,0,0,0]
export var lightTexture : Array = [Object(),Object(),Object(),Object(),Object(),Object()]


export var glowTexture : Array = [Object(),Object(),Object(),Object(),Object(),Object()]
export var glowEnergy : PoolRealArray = [0,0,0,0,0,0]
export var glowOffset : PoolVector2Array = [Vector2(), Vector2(), Vector2(), Vector2(), Vector2(), Vector2()]

onready var parent := get_parent()

func _process(delta):
	$light.texture_scale = lightSize[parent.growthDays] 
	$light.energy = lightEnergy[parent.growthDays] 
	$light.texture = lightTexture[parent.growthDays]
	
	$glowLight.position = glowOffset[parent.growthDays]
	$glowLight.texture = glowTexture[parent.growthDays]
	$glowLight.energy = glowEnergy[parent.growthDays]
