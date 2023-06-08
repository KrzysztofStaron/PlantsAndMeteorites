extends object
class_name Building
signal build

export var builded := false

func _ready():
	if builded:
		build()

func startBuilding(buildTime : float) -> void:
	if buildTime > 0:
		get_node("Sprite/buildTimer").connect("timeout", self, "build")
		get_node("Sprite/buildTimer").start(buildTime)
		
		get_node("Sprite/building").play("building")
	else:
		build()

func build() -> void:
	emit_signal("build")
	builded = true
	print("build")
	
	for buildStuf in $Sprite.get_children():
		if buildStuf.name == "buildTimer":
			buildStuf.queue_free()
		elif buildStuf.name == "building":
			buildStuf.play("stop")
