extends Sprite

var goal : Vector2
var center : Vector2

func _ready():
	center = position
	$"../wypizdochuj".interpolate_property(self, "global_position", global_position, goal, randf()+0.2, Tween.TRANS_BACK, Tween.EASE_IN)
	$"../wypizdochuj".start()

func _on_wypizdochuj_tween_completed(object, key):
	var radius = 40;
	var angle = randf() * 360;
	var x = radius * sin(PI * 2 * angle / 360);
	var y = radius * cos(PI * 2 * angle / 360);

	goal = center + Vector2(x, y)
	
	$"../wypizdochuj".interpolate_property(self, "global_position", global_position, goal, randf()+0.2, Tween.TRANS_BACK, Tween.EASE_IN)
	$"../wypizdochuj".start()
