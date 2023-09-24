extends Control

export var item : Resource

func _ready():
	if item != null:
		$buyItem.texture = item.texture
		$price.text = str(item.buy_price)
	else:
		hide()

func _process(delta):
	if item:
		$buy.disabled = item.buy_price > GameManager.money

func _on_buy_pressed():
	if item.buy_price <= GameManager.money:
		GameManager.money -= item.buy_price
		item.quantity = 1
		$"../../bought".order(item)
