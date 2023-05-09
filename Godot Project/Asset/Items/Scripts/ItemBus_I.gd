extends Node2D

var itemID = 0
var itemData: String  = ""
var currentItem : String = ""
var itemPaths = []
var itemResources = []

func _ready():
	var file_list = ("res://Asset/Items/Item_Resources/")
	var dir = Directory.new()
	dir.open(file_list)
	dir.list_dir_begin(true,true)
	var fileName = dir.get_next()
	
	while fileName != "":
		var filePath = file_list+ "/" + fileName
		print(filePath)
		itemPaths.append(filePath)
		fileName = dir.get_next()
	dir.list_dir_end()
	for file in itemPaths:
		itemResources.append(ResourceLoader.load(file))

func getItemDetails(ItemID)-> Resource:
	for resource in itemResources:
		if resource.getID() == ItemID:
			return resource
	return null
func getAllItems()-> Array:
	return itemResources

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
