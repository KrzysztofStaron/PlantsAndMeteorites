extends Control

onready var money := $money

func _process(delta):
	money.text = str(GameManager.money)


func _on_Button_pressed():
	visible = !visible


func _on_order_pressed():
	GameManager.ordered = $bought.inventory
