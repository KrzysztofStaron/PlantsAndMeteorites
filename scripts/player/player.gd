extends KinematicBody2D

class_name Player
export var inOxygen : bool
export var oxygen := 0.0
export var maxOxygen := 180.0

func _ready():
	GameManager.player = self

func _process(delta):
	inOxygen = $oxygenDetector.get_overlapping_areas().size() or $oxygenDetector.get_overlapping_bodies().size()
	if inOxygen:
		if oxygen <= maxOxygen:
			oxygen += delta*20
		else:
			oxygen = maxOxygen
	else:
		if oxygen <= 0:
			print("udusiłeś sie")
		else:
			oxygen -= delta

	$"../UI/oxygen/fill".material.set_shader_param("persent", oxygen/maxOxygen)
