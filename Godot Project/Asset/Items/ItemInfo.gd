extends Control
export (Resource) var ItemResorce = item.new()

func DisplayItemData():
	print("print")
	get_child(0).texture = ItemResorce.texture
	get_child(1).text = ItemResorce.name
	print(ItemResorce.name)
	get_child(2).text = ItemResorce.hover_text
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayItemData()
	ItemResorce.testPrint()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
