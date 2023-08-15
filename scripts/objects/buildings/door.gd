extends Building

export var opened := false
var changeState := false
	
func interact_left():
	var item = Inventory.getSelectedItem()
	if item == null:
		return

	if item.type == "tool" and item.toolType == Tool.Hammer:
		destroy()
		
func destroy():
	instanceLoot(load("res://data/items/buildings/door.tres"), preload("res://scenes/objects/buildings/IronWall/destroy.tscn"))
	queue_free()

func interact_right():
	if !drawOutline or !outlineEnabled:
		return
	
	opened = !opened
	if opened:
		$AnimationPlayer.play("open")
	else:
		$AnimationPlayer.play("close")

func _on_playerDetector_body_entered(body):
	if $AnimationPlayer.current_animation_length == $AnimationPlayer.current_animation_position:
		$AnimationPlayer.play("open")
	else:
		changeState = true

func _on_playerDetector_body_exited(body):
	if $AnimationPlayer.current_animation_length == $AnimationPlayer.current_animation_position:
		$AnimationPlayer.play("close")
	else:
		changeState = true

func _on_AnimationPlayer_animation_finished(anim_name):
	if !changeState:
		pass
	elif len($playerDetector.get_overlapping_bodies()) == 0:
		changeState = false
		$AnimationPlayer.play("close")
	elif len($playerDetector.get_overlapping_bodies()) != 0:
		changeState = false
		$AnimationPlayer.play("open")
