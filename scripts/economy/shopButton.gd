extends TextureButton

func _on_rocketUI_closed():
	show()

func _on_rocketUI_opened():
	hide()

func _on_mainInventory_closed():
	show()

func _on_mainInventory_opened():
	hide()
