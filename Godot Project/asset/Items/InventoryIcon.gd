extends TextureRect

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var currentItem = item.new()

# Called when the node enters the scene tree for the first time.
func setUpItemSprite(itemId = 0, quantity = 1) -> void:
	currentItem.setUpItem(itemId,quantity)
	set_texture(currentItem.getTexture())
	pass
	
func getItem() -> item:
	return currentItem
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
