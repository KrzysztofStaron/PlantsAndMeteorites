extends Control

export var item : Resource

func _ready():
	if item != null:
		$buyItem.texture = item.texture
		$price.text = str(item.buy_price)
	else:
		hide()
	
func _on_buy_pressed():
	var sum := 0
	for x in $"../../bought/GridContainer".get_children():
		var itemToCount : InventoryItem = x.get_node("../../").inventory[x.index] 
		if itemToCount  is CountableItem:
			sum += itemToCount.buy_price * itemToCount.quantity
		elif itemToCount == null:
			pass
		else:
			sum += itemToCount.buy_price
			
	print(sum)
	
	if sum+item.buy_price <= GameManager.money:
		item.quantity = 1
		$"../..".subMoney = sum+item.buy_price
		$"../../bought".order(item)
