extends object
class_name Building
signal build

export var builded := false
export var path := "../"
export var isFloor : bool
export var collisionPath : NodePath 

var lights : Array
export var energies : PoolRealArray

func enableOutline():
	$Sprite.material = preload("res://assets/objects/outline.tres").duplicate()
	outlineEnabled = true

func instanceLoot(droppedItem : InventoryItem, particle : PackedScene = null) -> void:
	if particle != null:
		var destroy : Node = particle.instance()
		destroy.position = position
		destroy.emitting = true
		get_parent().add_child(destroy)

	var dropScene : Node = load("res://scenes/droppedItem.tscn").instance()
	dropScene.position = position
	dropScene.item = droppedItem.duplicate()
	get_parent().add_child(dropScene)
	queue_free()

func _process(delta):
	if len(lights) > 0:
		for i in len(lights):
			lights[i].energy = energies[i] * GameManager.overallBrightness

func _ready():
	for child in get_children():
		if child is Light2D:
			lights.append(child)
			energies.append(child.energy)
	
	get_tree().get_root().get_node("main/drone/sprite").center = global_position
	if builded:
		o_build()

func startBuilding(buildTime : float) -> void:
	if buildTime > 0:
		get_node("Sprite/buildTimer").connect("timeout", self, "o_build")
		get_node("Sprite/buildTimer").start(buildTime)
		
		get_node("Sprite/building").play("building")
	else:
		o_build()


# Original build() call
func o_build() -> void:
	builded = true
	emit_signal("build")
	get_tree().get_root().get_node("main/drone/sprite").center = Vector2(0,0)
	build()
	
func build() -> void:
	if drawOutline:
		enableOutline()

	if get_node_or_null("Sprite"):
		for buildStuf in $Sprite.get_children():
			if buildStuf.name == "buildTimer":
				buildStuf.queue_free()
			elif buildStuf.name == "building":
				buildStuf.play("stop")
