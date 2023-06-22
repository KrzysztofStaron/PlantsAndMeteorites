extends object

export var item : Resource
export var amount : int
var empty := false

func _ready():
	item.quantity = amount

func interact_right():
	if empty:
		return
	drawOutline = false
	$Sprite.material.set_shader_param("width", 0)

	if Inventory.addToinventory(item):
		$AnimationPlayer.play("picekdUp")
		empty = true
