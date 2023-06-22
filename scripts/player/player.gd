extends KinematicBody2D

class_name Player
export var inOxygen : bool
export var oxygen := 0.0
export var maxOxygen := 180.0

export var scaleCurve : Curve
export var colorCurve : Curve

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
		if oxygen < 0.75:
			$"../UI/vignete/death".playing = true
			$"../UI/vignete/death".show()
			hide()
		elif oxygen < 1.0:
			$"../UI/vignete/anim".play("start")

		oxygen -= delta
	
	if oxygen > 0:
		var vigneteScale := 0.5*scaleCurve.interpolate(1.0 - oxygen/maxOxygen)
		var vigneteColor := Color(0,0,0, 0.64 + colorCurve.interpolate(1.0 - oxygen/maxOxygen) * 0.36)
		
		$"../UI/vignete".get_material().set_shader_param("SCALE", vigneteScale)
		$"../UI/vignete".get_material().set_shader_param("color", vigneteColor)
	else:
		$"../UI/vignete".get_material().set_shader_param("SCALE", 0)
		$"../UI/vignete".get_material().set_shader_param("color", Color(0,0,0,1))

	$"../UI/oxygen/fill".material.set_shader_param("persent", oxygen/maxOxygen)


func _on_death_animation_finished():
	get_tree().change_scene("res://scenes/ui/DeathScreen.tscn")
