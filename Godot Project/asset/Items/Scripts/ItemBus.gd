extends Node2D

var itemID = 0
var itemData = ""
var currentItem = ""
onready var item = load("res://asset/Items/Scripts/Item.gd")

func getItemDetails(ItemID):
	match itemID: #Name, SpriteFilePath, +/Description"
		0: itemData = "name,res://asset/Rafael - EPIC RPG World Pack - Ancient Ruins V 1.7/Props/Obelisk1-stand.png"\
			+",Test item with no particular use"
		1: itemData = "name,filepath"\
			+",Test item with no particular use"

func getName(ItemID):
	itemData = getItemDetails(ItemID)
	return itemData.get_slice(",",0)

func getSpriteFile(ItemID):
	itemData = getItemDetails(ItemID)
	return itemData.get_slice(",",1)
	pass

func getHoverText(ItemID):
	itemData = getItemDetails(ItemID)
	return itemData.get_slice(",",2)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
