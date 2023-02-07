extends Node2D

var itemID = 0
var itemData: String  = ""
var currentItem : String = ""

func getItemDetails(ItemID)-> String:
	match ItemID: #Name, SpriteFilePath, +/Description"
		0:
			itemData = "name,"
			itemData += "res://asset/res://asset/Rafae_Ancient_Ruins_V-1-7/Props/Obelisk1-stand.png,"
			itemData += "Test item with no particular use"
		1: itemData = "name,filepath,Test item with no particular use"
	return itemData

func getName(ItemID) -> String:
	itemData = getItemDetails(ItemID)
	return itemData.get_slice(",",0)

func getTexture(ItemID):
	itemData = getItemDetails(ItemID)
	return itemData.get_slice(",",1)

func getHoverText(ItemID):
	itemData = getItemDetails(ItemID)
	return itemData.get_slice(",",2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
