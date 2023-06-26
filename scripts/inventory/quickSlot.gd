extends TextureButton
class_name quickInventorySlot

export var storage := true
export var debug := false
export var index : int
var touch := false
var flag := false
var is_dragging := false

func getItem() -> InventoryItem:
	return Inventory.inventory[index]
	
func setItem(item : InventoryItem):
	Inventory.inventory[index] = item

func _input(event):
	if not event is InputEventMouseMotion:
		pass
	elif getItem() == null:
		pass
	elif len(get_tree().get_root().get_node("main/drag/draggedItem/detector").get_overlapping_areas()) == 0:
		pass
	elif get_tree().get_root().get_node("main/drag/draggedItem/detector").get_overlapping_areas()[0].get_parent() != self:
		pass
	elif flag:
		if debug:
			print("drag")
		is_dragging = true
		$icon.visible = false
		get_tree().get_root().get_node("main/drag/draggedItem").visible = true
		get_tree().get_root().get_node("main/drag/draggedItem").item = getItem()
		get_tree().get_root().get_node("main/drag/draggedItem").update()
		
	if event is InputEventMouseButton:
		flag = Input.is_mouse_button_pressed(BUTTON_LEFT) and touch
		if debug:
			print(flag)

		if is_dragging and !Input.is_mouse_button_pressed(BUTTON_LEFT):
			is_dragging = false
			$icon.visible = true
			get_tree().get_root().get_node("main/drag/draggedItem").visible = false
			
			if len(get_tree().get_root().get_node("main/drag/draggedItem/detector").get_overlapping_areas()):
				var original := getItem().duplicate()
				var slot : Node = get_tree().get_root().get_node("main/drag/draggedItem/detector").get_overlapping_areas()[0].get_parent()
				
				if !slot.storage or slot == self:
					pass
				elif slot.getItem() == null and !storage:
					setItem(null)
					slot.setItem(original)
				elif slot.getItem() != null:
					if slot.getItem().name == getItem().name:
						original.quantity += slot.getItem().quantity
						setItem(null)
						slot.setItem(original)
					elif storage:
						setItem(slot.getItem().duplicate())
						slot.setItem(original)
				elif storage:
					setItem(null)
					slot.setItem(original)
					

func _on_quickSlot_mouse_entered():
	touch = true

func _on_quickSlot_mouse_exited():
	touch = false
