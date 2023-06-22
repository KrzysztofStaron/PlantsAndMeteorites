extends Sprite

var goal : Vector2
var center : Vector2
var angleOffset : float

func _ready():
	center = position
	$"../wypizdochuj".interpolate_property(self, "global_position", global_position, goal, randf()+0.2, Tween.TRANS_BACK, Tween.EASE_IN)
	$"../wypizdochuj".start()

func _process(delta):
	angleOffset += delta * 180.0
	
func _on_wypizdochuj_tween_completed(object, key):
	var radius = 30;
	var angle = angleOffset;
	var x = radius * sin(PI * 2 * angle / 360);
	var y = radius * cos(PI * 2 * angle / 360);

	goal = center + Vector2(x, y)
	
	$"../wypizdochuj".interpolate_property(self, "global_position", global_position, goal, 0.6, Tween.TRANS_BACK, Tween.EASE_IN)
	$"../wypizdochuj".start()
