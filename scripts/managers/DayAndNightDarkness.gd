extends Control

export var parent := false
export var devider := 1.6
onready var parentNode := get_parent()

func _process(delta):
	var brightness := (1.0-GameManager.overallBrightness) / devider
	brightness += 1.0 - (1.0/devider)
	if parent:
		parentNode.modulate = Color(brightness , brightness, brightness, 1.0)
	else:
		modulate = Color(brightness , brightness, brightness, 1.0)
