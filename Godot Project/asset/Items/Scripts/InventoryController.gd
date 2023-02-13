extends Control
onready var itemSprite = load("res://asset/Items/ItemSprite.tscn")
var Items = ""

onready var equiptObject = $HBoxContainer2/EquipContainer/PanelContainer3/EquipContainers
onready var keyObject = $HBoxContainer2/InventoryContainer/VBoxContainer/KeyItems
onready var consumeableObject = $HBoxContainer2/InventoryContainer/VBoxContainer/Consumables
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	setGroup("Equip(2,1)",equiptObject)
	setGroup("Key(0,1,0)",keyObject)
	setGroup("Consumeable(2,1,0,1)",consumeableObject)
	
	
func setGroup(inventoryGroup = "", groupNode = null):
	var tempItems = inventoryGroup
	var groupCategory = inventoryGroup.get_slice("(",0)
	tempItems = "(" + tempItems
	print_debug(tempItems)
	tempItems.lstrip(groupCategory + "(")
	tempItems.rstrip(")")
	for itemPosition in range(0,tempItems.count(",")+1,+1):
		groupNode.add_child(fillInventory(itemPosition, tempItems))
func fillInventory(ItemPosition, TempItems):
	var itemId = TempItems.get_slice(",", ItemPosition).to_int()
	var currentItemSprite = itemSprite.instance()
	currentItemSprite.setUpItemSprite(itemId,1)
	return currentItemSprite

	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
