extends Node

var itemID = 0
var itemData: String  = ""
var currentItem : String = ""

func getHScene(H )-> String:
	match ItemID: #Name, SpriteFilePath, +/Description"
		0:
			itemData = "res://asset/HScenes/SpriteAnimations/HScene_Slime_eri V2-Sheet.png,"
			itemData += "res://dialogue/dialog_text(Dialog_manager)/dialog_manager.tres"
		1: 
			itemData = "Golden Pyramid 2,"
			itemData += "res://asset/Sprites/Items/Obelisk1_02-stand.png,"
		2: 
			itemData = "Golden Pyramid 3,"
			itemData += "res://asset/Sprites/Items/Obelisk1_03-stand.png,"
	return itemData

func getImage(ItemID):
	itemData = getHScene(ItemID)
	var expTexture = load(itemData.get_slice(",",0))
	return expTexture

func getHoverText(ItemID):
	itemData = getHScene(ItemID)
	return itemData.get_slice(",",1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
