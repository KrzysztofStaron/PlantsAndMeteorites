extends CountableItem
class_name BuildingItem

export var scene : PackedScene
export var buildingTime : float
export var showcaseTexture : Texture
export var showcaseOffset : Vector2
export(int, "non", "2dir", "2dirMirorX", "4dir") var rotation : int
export var isFloor : bool
