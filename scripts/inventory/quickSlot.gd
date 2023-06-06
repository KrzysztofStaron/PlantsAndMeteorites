extends TextureButton

export var index : int
var touch := false
var flag := false
var is_dragging := false

func getItem() -> InventoryItem:
	return Inventory.inventory[index]
	
func setItem(item : InventoryItem):
	Inventory.inventory[index] = item

func _input(event):	
	if flag && event is InputEventMouseMotion:
		is_dragging = true
		$icon.visible = false
		owner.get_node("../draggedItem").visible = true
		owner.get_node("../draggedItem").item = getItem()
		owner.get_node("../draggedItem").update()
		
	if event is InputEventMouseButton:
		if Input.is_mouse_button_pressed(BUTTON_LEFT) and touch:
			flag = true
		else:
			flag = false

		if is_dragging and !Input.is_mouse_button_pressed(BUTTON_LEFT):
			is_dragging = false
			$icon.visible = true
			owner.get_node("../draggedItem").visible = false
			
			if len(owner.get_node("../draggedItem/detector").get_overlapping_areas()):
				var original := getItem()
				var slot : Node = owner.get_node("../draggedItem/detector").get_overlapping_areas()[0].get_parent()
				setItem(slot.getItem())
				slot.setItem(original)

func _on_quickSlot_mouse_entered():
	touch = true

func _on_quickSlot_mouse_exited():
	touch = false
