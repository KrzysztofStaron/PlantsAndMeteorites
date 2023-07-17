extends Control

onready var asteroids : Array = [
	[preload("res://scenes/screens/menu/asteroid1.tscn"), 5],  # Array of asteroid scenes and their masses
	[preload("res://scenes/screens/menu/asteroid2.tscn"), 3],
	[preload("res://scenes/screens/menu/asteroid3.tscn"), 2],
	[preload("res://scenes/screens/menu/asteroid4.tscn"), 3],
	[preload("res://scenes/screens/menu/asteroid5.tscn"), 2],
	[preload("res://scenes/screens/menu/asteroid6.tscn"), 1]
]

export var maxMass := 90  # Maximum mass allowed for the asteroids

func _ready():
	updateAsteroids(true)  # Call the function to update asteroids when ready

func play():
	get_tree().change_scene("res://scenes/main.tscn")  # Change the scene to "main.tscn" when the play button is pressed

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
	var sumOfMass := 0  # Initialize the sum of masses of existing asteroids to zero
	for asteroid in get_tree().get_nodes_in_group("asteroid"):
		sumOfMass += asteroid.mass  # Calculate the sum of masses of existing asteroids
		
	var usableMass := maxMass - sumOfMass  # Calculate the available mass for new asteroids
	
	while !(usableMass <= 1):  # Keep looping until the available mass is less than or equal to 1
		var index := int(rand_range(0, 6))  # Randomly select an index for the asteroid type
		
		if asteroids[index][1] <= usableMass:  # Check if the selected asteroid type can fit within the available mass
			if !start and randf() < 0.2:
				pass
			else:
				usableMass -= asteroids[index][1]  # Reduce the available mass by the mass of the selected asteroid
			
			var newAsteroid : RigidBody2D = asteroids[index][0].instance()  # Instantiate a new asteroid from the asteroid scene
			newAsteroid.mass = asteroids[index][1]  # Set the mass of the new asteroid
			if start:
				newAsteroid.position = getRandomScreenPosition()  # Set the position of the new asteroid randomly within the screen
			else:
				newAsteroid.position = getRandomEdgePosition()  # Set the position of the new asteroid randomly on the screen edge
				
			get_node("container").call_deferred("add_child", newAsteroid)  # Add the new asteroid as a child to the "container" node
			newAsteroid.apply_impulse(Vector2(320,180)/2, Vector2(rand_range(-5, 5), rand_range(-5, 5)))  # Apply an impulse to the new asteroid
