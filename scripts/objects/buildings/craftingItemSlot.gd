extends TextureButton

export var recipe : Resource

func _ready():
	if recipe != null:
		$icon.texture = recipe.item.texture

func _pressed():
	$"..".hide()
	$"../../require".show()
	for require in $"../../require".get_children():
		require.hide()
			
	for i in len(recipe.amounts):
		$"../../require".get_children()[i].show()
		$"../../require".get_children()[i].get_node("icon").texture = recipe.require[i].texture
		$"../../require".get_children()[i].get_node("amount").text = str(recipe.amounts[i])
			
	$"../../craft".show()
