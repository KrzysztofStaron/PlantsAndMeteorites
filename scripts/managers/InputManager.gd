# It's a tool that I made long time ago, it helps a lot with management of movement related Inputs

extends Node

var pressed : Dictionary

var last_inputsPairs := []

func _process(_delta):
	for input in last_inputsPairs:
		if Input.is_action_just_pressed(input[0]):
			pressed[input[0]] = input[0]
		elif Input.is_action_just_pressed(input[1]):
			pressed[input[0]] = input[1]
		elif Input.is_action_just_released(input[1]):
			if Input.is_action_pressed(input[0]):
				pressed[input[0]] = input[0]
			else:
				pressed[input[0]] = ""
		elif Input.is_action_just_released(input[0]):
			if Input.is_action_pressed(input[1]):
				pressed[input[0]] = input[1]
			else:
				pressed[input[0]] = ""

# WIP
func last_vector(n1 : String, p1 : String, n2 : String, p2 : String, reversed := false) -> Vector2:
	var dir := Vector2(last_axis(n1, p1, reversed), last_axis(n2, p2, reversed))
	if abs(dir.x) + abs(dir.y) > 1.4:
		dir = dir.normalized()
	
	return dir

func last_axis(negative_input : String, positive_input : String, reversed : bool = false) -> int:
	var direction := 1 if !reversed else -1
	
	if !pressed.has(negative_input):
		pressed[negative_input] = ""
	
	if !(Input.is_action_pressed(negative_input) or Input.is_action_pressed(positive_input)):
		return 0
	elif pressed[negative_input] != positive_input and Input.is_action_pressed(negative_input):
		return -1 * direction
	elif pressed[negative_input] != negative_input and Input.is_action_pressed(positive_input):
		return 1 * direction
	else:
		return 0

func axis(negative_input : String, positive_input : String, reversed : bool = false) -> int:
	var direction := 1 if !reversed else -1 

	if !pressed.has(negative_input):
		pressed[negative_input] = ""

	if !(Input.is_action_pressed(negative_input) or Input.is_action_pressed(positive_input)):
		pressed[negative_input] = ""
		return 0
	elif pressed[negative_input] != positive_input && Input.is_action_pressed(negative_input):
			pressed[negative_input] = negative_input
			return -1 * direction
			
	elif pressed[negative_input] != negative_input && Input.is_action_pressed(positive_input):
			pressed[negative_input] = positive_input
			return 1 * direction
	else:
		if pressed[negative_input] != negative_input:
			pressed[negative_input] = negative_input
			return -1 * direction
		else:
			pressed[negative_input] = positive_input
			return 1 * direction

func vector(n1 : String, p1 : String, n2 : String, p2 : String, reversed := false) -> Vector2:
	var dir := Vector2(axis(n1, p1, reversed), axis(n2, p2, reversed))
	if abs(dir.x) + abs(dir.y) > 1.4:
		dir = dir.normalized()
	
	return dir
