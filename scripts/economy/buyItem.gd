extends Control

export var item : Resource

func _ready():
	if item != null:
		$buyItem.texture = item.texture
		$price.text = str(item.buy_price)
	else:
		hide()
	


func _on_buy_pressed():
	$"../../bought".order(item)
