tool
extends TextureRect
export(Resource) var my_item setget _setItem


onready var my_label = $RichTextLabel
func _ready() -> void:
	var ItemID = 0
	var new_item
	my_item = new_item.initialize(ItemID)
func _init(ItemID):
	var new_item
	my_item = new_item.initialize(ItemID)
func addQuantity(added_quant : int):
	my_item.addQuantity(added_quant)
func _setItem(new_item : Resource):
	self.texture = my_item.getTexture()
	$RichTextLabel.bbcode_text = new_item.get_quantity()
func itemPortrait(new_item : Resource):
	pass
