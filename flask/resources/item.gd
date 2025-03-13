extends Resource

class_name Item

# This is used to define the type of the item
# Example: When you want to check if an item is a potion use: if item.type == Item.Type.POTION
enum Type {INGREDIENT, POTION}

@export var type: Type
@export var name: String = ""
@export var texture: Texture2D
