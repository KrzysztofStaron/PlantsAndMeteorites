extends Building

export var powered := false

func interact_right():
	powered = !powered
	update()
	

func update():
	for obj in $cableDetector.get_overlapping_areas():
		if obj is preload("res://scripts/objects/buildings/lightCable.gd"):
			if !powered:
				obj.powered = false
			elif not obj.powered:
				obj.powered = true


func _on_cableDetector_body_entered(body):
	if body is preload("res://scripts/objects/buildings/lightCable.gd"):
		update()
		body.level = 0
