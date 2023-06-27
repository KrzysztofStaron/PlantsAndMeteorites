extends Resource
class_name InventoryItem

export var name := ""
export(String, "item", "seed", "tool", "building") var type : String
export var texture : Texture
export var sell_price : int
export var buy_price : int
