extends Building

var opened := false
var touchMouse := false

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

func hideOutline():
	$Sprite.material.set_shader_param("width", 0)
	
func showOutline():
	if touchMouse:
		$Sprite.material.set_shader_param("width", outlineWidth)
	


func _on_tileCollision_mouse_entered():
	touchMouse = true


func _on_tileCollision_mouse_exited():
	touchMouse = false
