extends KinematicBody2D

class_name Player
export var inOxygen : bool
export var maxOxygen := 180.0
export var oxygen := 0.0

export var scaleCurve : Curve
export var colorCurve : Curve

var hiden := false
export var stopSound := false
export var sound : float

func _ready():
	GameManager.player = self
	$gasping.play(0.0)

func _process(delta):
	inOxygen = $oxygenDetector.get_overlapping_areas().size() or $oxygenDetector.get_overlapping_bodies().size()
	if inOxygen:
		if oxygen <= maxOxygen:
			oxygen += delta*40
			
			if oxygen/maxOxygen > 0.1 and hiden:
				$"../UI/vignete/anim".play("show")
				hiden = false
		else:
			oxygen = maxOxygen
	else:
		if oxygen < 2:
			$sound.play("fade")
			stopSound = true

		if oxygen < 0.2:
			$"../UI/vignete/death".playing = true
			$"../UI/vignete/death".show()
			hide()
		elif oxygen/maxOxygen < 0.015:
			hiden = true
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
	
	if !stopSound:
		$gasping.volume_db = linear2db(0.4 - (0.4*scaleCurve.interpolate(1.0 - oxygen/maxOxygen)))
	else:
		$gasping.volume_db = linear2db(sound)
	
	$"../UI/oxygen/fill".material.set_shader_param("persent", oxygen/maxOxygen)


func _on_death_animation_finished():
	get_tree().change_scene("res://scenes/deathScreen/DeathScreen.tscn")
