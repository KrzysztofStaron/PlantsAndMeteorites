class_name State

extends Node

var state_machine = null

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(_event: InputEvent) -> void:
	pass

# Called when state is changed
func exit() -> void:
	pass

# Called when state is used
func enter(_data := {}) -> void:
	pass

# _process()
func update(_delta : float) -> void:
	pass

# _physics_process()
func physics_update(_delta : float) -> void:
	pass
