extends Control
export var subMoney : int

func _process(delta):
	if Input.is_action_just_pressed("debug_shop"):
		visible = !visible
		
	$money.text = str(GameManager.money - subMoney)


func _on_Button_pressed():
	visible = !visible


func _on_order_pressed():
	GameManager.ordered = $bought.inventory
