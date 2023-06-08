extends Building

func _on_oxygenMachine_build():
	$AnimationPlayer.play("idle")
	$oxygen.disabled = false
