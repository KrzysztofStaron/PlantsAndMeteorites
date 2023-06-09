extends TextureButton

export var recipe : Resource

func _ready():
	if recipe != null:
		$icon.texture = recipe.item.texture

func _pressed():
	if recipe != null:
		$"../../amountSlider".show()
		$"../../amountSlider/number".text = "1"
		$"..".hide()
		$"../../require".show()
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
				
		$"../../amountSlider".max_value = numberOfItem
	else:
		pressed = false
