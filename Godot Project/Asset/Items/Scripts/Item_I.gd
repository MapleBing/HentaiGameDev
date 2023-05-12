extends Resource
class_name item

export(int) var id
export(String) var name
export(Texture) var texture
export(bool) var stackable
export(String) var hover_text

enum ItemTypes { KEY, CONSUMEABLE, EQUIPABLE}
export(ItemTypes) var type

func testPrint():
	print("Working")


