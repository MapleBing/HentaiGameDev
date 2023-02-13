extends Node2D

var itemID = 0
var itemData: String  = ""
var currentItem : String = ""

func getItemDetails(ItemID)-> String:
	match ItemID: #Name, SpriteFilePath, +/Description"
		0:
			itemData = "name,"
			itemData += "res://asset/Sprites/Items/Obelisk1_01-stand.png,"
			itemData += "Test item with no particular use"
		1: 
			itemData = "name,"
			itemData += "res://asset/Sprites/Items/Obelisk1_02-stand.png,"
			itemData += "Test item with no particular use"
		2: 
			itemData = "name,"
			itemData += "res://asset/Sprites/Items/Obelisk1_03-stand.png,"
			itemData += "Test item with no particular use"
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
