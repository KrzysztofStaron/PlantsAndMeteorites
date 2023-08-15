extends Control

export var parent := false

func _process(delta):
	var brightness := (1.0-GameManager.overallBrightness) / 1.7
	brightness += 0.411765
	if parent:
		get_parent().modulate = Color(brightness , brightness, brightness, 1.0)
	else:
		modulate = Color(brightness , brightness, brightness, 1.0)
