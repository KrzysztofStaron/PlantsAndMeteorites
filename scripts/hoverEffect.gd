extends Tween

export var hoverColor : Color
export var normalColor : Color

export var transTime := 0.1

func _ready():
	if get_parent().connect("mouse_exited", self, "_mouse_exited"):
		print("HoverEffect: failed to connect")
	if get_parent().connect("mouse_entered", self, "_mouse_entered"):
		print("HoverEffect: failed to connect")

func _mouse_entered():
	if interpolate_property(get_parent(), "modulate", normalColor, hoverColor, transTime, Tween.TRANS_SINE, Tween.EASE_IN):
		pass
	if !start():
		print("HoverEffect: failed to start")

func _mouse_exited():
	if interpolate_property(get_parent(), "modulate",hoverColor, normalColor, transTime, Tween.TRANS_SINE, Tween.EASE_IN):
		pass
	if !start():
		print("HoverEffect: failed to start")
