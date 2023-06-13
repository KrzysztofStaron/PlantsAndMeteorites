extends object
class_name Building
signal build

export var builded := false
export var path := "../"

func _ready():
	if builded:
		build()

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
	build()
	
func build() -> void:
	print("build")
	if get_node_or_null("Sprite"):
		for buildStuf in $Sprite.get_children():
			if buildStuf.name == "buildTimer":
				buildStuf.queue_free()
			elif buildStuf.name == "building":
				buildStuf.play("stop")
