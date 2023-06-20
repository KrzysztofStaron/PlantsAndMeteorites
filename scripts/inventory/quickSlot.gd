extends TextureButton
class_name quickInventorySlot

export var index : int
var touch := false
var flag := false
var is_dragging := false

func _process(delta):
	print(len(get_tree().get_root().get_node("main/UI/draggedItem/detector").get_overlapping_areas()))
	
func getItem() -> InventoryItem:
	return Inventory.inventory[index]
	
func setItem(item : InventoryItem):
	Inventory.inventory[index] = item

func _input(event):
	if !len(get_tree().get_root().get_node("main/UI/draggedItem/detector").get_overlapping_areas()):
		pass
	elif get_tree().get_root().get_node("main/UI/draggedItem/detector").get_overlapping_areas()[0].get_parent() != self:
		pass
	elif flag && event is InputEventMouseMotion:
		is_dragging = true
		$icon.visible = false
		get_tree().get_root().get_node("main/UI/draggedItem").visible = true
		get_tree().get_root().get_node("main/UI/draggedItem").item = getItem()
		get_tree().get_root().get_node("main/UI/draggedItem").update()
		
	if event is InputEventMouseButton:
		flag = Input.is_mouse_button_pressed(BUTTON_LEFT) and touch

		if is_dragging and !Input.is_mouse_button_pressed(BUTTON_LEFT):
			is_dragging = false
			$icon.visible = true
			get_tree().get_root().get_node("main/UI/draggedItem").visible = false
			
			if len(get_tree().get_root().get_node("main/UI/draggedItem/detector").get_overlapping_areas()):
				var original := getItem()
				var slot : Node = get_tree().get_root().get_node("main/UI/draggedItem/detector").get_overlapping_areas()[0].get_parent()
				setItem(slot.getItem())
				slot.setItem(original)

func _on_quickSlot_mouse_entered():
	touch = true

func _on_quickSlot_mouse_exited():
	touch = false
