extends Building

func _ready():
	GameManager.cloningStations.append(self)
