extends TextureButton

export var recipe : Resource

func _ready():
	if recipe != null:
		$icon.texture = recipe.item.texture

func _pressed():
	pressed = true
	$"../../amountSlider".show()
	$"..".hide()
	$"../../require".show()
	$"../../back".show()
	for require in $"../../require".get_children():
		require.hide()
			
	for i in len(recipe.amounts):
		$"../../require".get_children()[i].show()
		$"../../require".get_children()[i].get_node("icon").texture = recipe.require[i].texture
		$"../../require".get_children()[i].get_node("amount").text = str(recipe.amounts[i])
			
	$"../../craft".show()
		
	var numberOfItem := -1
	for i in len(recipe.require):
		if numberOfItem > Inventory.countShit(recipe.require[i].name) / recipe.amounts[i] or numberOfItem == -1:
			numberOfItem = Inventory.countShit(recipe.require[i].name) / recipe.amounts[i]
	
	$"../../amountSlider/number".text = str(numberOfItem)
	$"../../amountSlider".value = numberOfItem
	$"../../amountSlider".max_value = numberOfItem


func togle(button_pressed):
	if pressed:
		_pressed()
