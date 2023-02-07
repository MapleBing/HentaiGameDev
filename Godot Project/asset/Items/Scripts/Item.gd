tool
extends Resource

class_name item

export(int) var item_id
export(String) var item_name
export(Texture) var item_texture
export(int) var quantity
export(String) var hover_text

func _init(Item_id, Quantity):
	item_id = Item_id
	setUpItem()
	addQuantity(Quantity)
	pass

func setUpItem():
	item_name = ItemBus.getName(item_id)
	item_texture = ItemBus.getTexture(item_id)
	hover_text = ItemBus.getHoverText(item_id)
	
func getName():
	return item_name
	
func addQuantity(added_quant : int):
	quantity += added_quant
	
func getQuantity(Quantity) -> int:
	return quantity
	
func getTexture() -> Texture:
	return item_texture
	
func getHoverText() -> String:
	return hover_text
	
