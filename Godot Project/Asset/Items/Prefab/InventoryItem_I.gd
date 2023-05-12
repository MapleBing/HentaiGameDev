extends TextureRect

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var currentItem = item.new()
export var quantity : int = 0
# Called when the node enters the scene tree for the first time.
func updateItem():
	texture = currentItem.texture
	if currentItem.stackable:
		get_child(0).text = str(quantity)
	else:
		 get_child(0).text = ""
func getID() -> int:
	return currentItem.getID()
	
func addQuantity(Quantity):
	quantity
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
