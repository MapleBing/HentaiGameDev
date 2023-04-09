extends Node2D

var itemID = 0
var itemData: String  = ""
var currentItem : String = ""

func getItemDetails(ItemID)-> String:
	match ItemID: #Name, SpriteFilePath, +/Description"
		0:
			itemData = "Golden Pyramid 1,"
			itemData += "res://asset/Sprites/Items/Obelisk1_01-stand.png,"
			itemData += "1st Test item with no particular use"
		1: 
			itemData = "Golden Pyramid 2,"
			itemData += "res://asset/Sprites/Items/Obelisk1_02-stand.png,"
			itemData += "2nd Test item with no particular use"
		2: 
			itemData = "Golden Pyramid 3,"
			itemData += "res://asset/Sprites/Items/Obelisk1_03-stand.png,"
			itemData += "3rd Test item with no particular use"
	return itemData

func getName(ItemID) -> String:
	itemData = getItemDetails(ItemID)
	return itemData.get_slice(",",0)

func getTexture(ItemID):
	itemData = getItemDetails(ItemID)
	var expTexture = load(itemData.get_slice(",",1))
	return expTexture

func getHoverText(ItemID):
	itemData = getItemDetails(ItemID)
	return itemData.get_slice(",",2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
