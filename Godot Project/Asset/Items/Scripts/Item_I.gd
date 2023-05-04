extends Resource
class_name item

export(int) var id
export(String) var name
export(Texture) var texture
export(int) var quantity
export(String) var hover_text

enum ItemTypes { KEY, CONSUMEABLE, EQUIPABLE}
export(ItemTypes) var type


func addQuantity(added_quant : int):
	quantity += added_quant
func testPrint():
	print("Working")


