extends AnimatedSprite

func _ready():
	playing = true

func _on_water_animation_finished():
	queue_free()
