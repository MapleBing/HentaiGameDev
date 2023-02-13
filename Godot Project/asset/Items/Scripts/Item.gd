tool
extends Resource

class_name item

export(int) var item_id
export(String) var item_name
export(Texture) var item_texture
export(int) var quantity
export(String) var hover_text

func setUpItem(Item_id = 0, Quantity = 0):
	item_name = ItemBus.getName(Item_id)
	item_texture = ItemBus.getTexture(Item_id)
	hover_text = ItemBus.getHoverText(Item_id)

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

