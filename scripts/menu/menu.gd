extends Control

export var clickEffect : PackedScene
var canShowEffect := true
var effectPos : Vector2

onready var asteroids : Array = [
	[preload("res://scenes/screens/menu/asteroid1.tscn")],  # Array of asteroid scenes and their masses
	[preload("res://scenes/screens/menu/asteroid2.tscn")],
	[preload("res://scenes/screens/menu/asteroid3.tscn")],
	[preload("res://scenes/screens/menu/asteroid4.tscn")],
	[preload("res://scenes/screens/menu/asteroid5.tscn")],
	[preload("res://scenes/screens/menu/asteroid6.tscn")]
]

export var maxMass := 90  # Maximum mass allowed for the asteroids

func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed("interact_left") and (canShowEffect or event.position.distance_to(effectPos) > 10):
			var effect :Node= clickEffect.instance()
			effect.position = event.position
			effectPos = event.position
			add_child(effect)
			canShowEffect = false
			$Timer.start(0.3)

func _ready():
	updateAsteroids(true)  # Call the function to update asteroids when ready

func play():
	get_tree().change_scene("res://scenes/screens/main.tscn")

func getRandomScreenPosition() -> Vector2:
	var screenWidth := 320
	var screenHeight := 180

	var position := Vector2()
	position.x = rand_range(0, screenWidth)  # Get a random X coordinate within the screen width
	position.y = rand_range(0, screenHeight)  # Get a random Y coordinate within the screen height

	return position

func getRandomEdgePosition() -> Vector2:
	var screenWidth := 320
	var screenHeight := 180

	var position := Vector2()

	var edge := int(rand_range(0, 3))  # Randomly select an edge: 0 = top, 1 = right, 2 = bottom, 3 = left

	match edge:
		0:  # Top edge
			position.x = rand_range(0, screenWidth)  # Get a random X coordinate within the screen width
			position.y = 0
		1:  # Right edge
			position.x = screenWidth
			position.y = rand_range(0, screenHeight)  # Get a random Y coordinate within the screen height
		2:  # Bottom edge
			position.x = rand_range(0, screenWidth)  # Get a random X coordinate within the screen width
			position.y = screenHeight
		3:  # Left edge
			position.x = 0
			position.y = rand_range(0, screenHeight)  # Get a random Y coordinate within the screen height

	return position

	
func updateAsteroids(start := false):
	var usableMass := maxMass  # Initialize the available mass for new asteroids to maxMass
	
	while usableMass > 1:  # Keep looping until the available mass is less than or equal to 1
		var index := int(rand_range(0, 6))  # Randomly select an index for the asteroid type
		
		if !start and randf() < 0.2:
			pass
		else:
			usableMass -= 1  # Reduce the available mass by 1 (no mass considerations)
			
			var newAsteroid : RigidBody2D = asteroids[index][0].instance()  # Instantiate a new asteroid from the asteroid scene
			if start:
				newAsteroid.position = getRandomScreenPosition()  # Set the position of the new asteroid randomly within the screen
			else:
				newAsteroid.position = getRandomEdgePosition()  # Set the position of the new asteroid randomly on the screen edge
				
			get_node("container").call_deferred("add_child", newAsteroid)  # Add the new asteroid as a child to the "container" node
			newAsteroid.apply_impulse(Vector2(320,180)/2, Vector2(rand_range(-5, 5), rand_range(-5, 5)))  # Apply an impulse to the new asteroid



func _on_Timer_timeout():
	canShowEffect = true
