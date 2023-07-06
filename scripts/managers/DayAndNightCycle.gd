extends CanvasModulate

export var colorGradient : Gradient
export var colorGradient2 : Gradient

func _process(delta):
	return
	var offset := (GameManager.time / GameManager.dayLenght) * 2
	if offset/2 < 0.5:
		color = colorGradient.interpolate(offset)
	else:
		color = colorGradient2.interpolate(1.0 - (offset-1.0))
