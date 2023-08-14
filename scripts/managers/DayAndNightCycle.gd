extends CanvasModulate

export var brightnessLevel : Gradient

func _process(delta):
	var offset := GameManager.time / GameManager.dayLenght
	color = brightnessLevel.interpolate(offset)
	GameManager.overallBrightness = (1.0 - ((color.r + color.g + color.b) / 3.0)) + 0.1
