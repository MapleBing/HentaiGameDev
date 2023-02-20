extends Control
onready var itemSprite = load("res://asset/Items/ItemSlot.tscn")
var Items = ""
var currentPosition = 0;
var currentSlot = 0;

onready var equipObject = $ItemDetails/EquipItems
onready var keyObject = $ItemDetails/KeyItems
onready var consumeableObject = $ItemDetails/ConsumeableItems

onready var ItemSection1 = $SectionBar/HBoxContainer/Control1/Panel
onready var ItemSection2 = $SectionBar/HBoxContainer/Control2/Panel
onready var ItemSection3 = $SectionBar/HBoxContainer/Control3/Panel
onready var EquipSection = $ItemDetails/EquipItems
onready var ConsumeableSection = $ItemDetails/ConsumeableItems
onready var KeySection = $ItemDetails/KeyItems
onready var ItemDetails = $ItemDetails
onready var ItemInfo = $ItemInfo

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	setGroup("Equip(2,1,2,0,0,2,1,2,0,0,0)",equipObject)
	setGroup("Key(0,1,0,0,0,0,1)",keyObject)
	setGroup("Consumeable(2,1,0,1,2,2,0)",consumeableObject)
	SignalBus.connect("inventoryMenuShiftRight", self, "leftInventoryMenuShift")
	SignalBus.connect("inventoryMenuShiftLeft", self, "rightInventoryMenuShift")
	SignalBus.connect("inventorySlotShift", self, "shiftInventorySlot")
	SignalBus.connect("inventoryMenuConfirm", self, "confirmInventoryMenu")
	shiftInventorySlot(0)
	
func confirmInventoryMenu():
	print_debug("________")
	print_debug(String(currentPosition)+ " " + String(currentSlot))
	addItem(getCurrentItemID(),1)
	pass
	
func addItem(itemID = 0,quantity = 0):
	var currentItemSprite: Node = itemSprite.instance()
	currentItemSprite.find_node("ItemSprite").setUpItemSprite(itemID,quantity)
	var currentObject
	
	match currentPosition:
		0:
			currentObject = equipObject
		1:
			currentObject = consumeableObject
		2:
			currentObject = keyObject
			
	currentObject.add_child(currentItemSprite)
	shiftInventorySlot(0)
	pass
	
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
	var currentItemSprite: Node = itemSprite.instance()
	currentItemSprite.find_node("ItemSprite").setUpItemSprite(itemId,1)
	return currentItemSprite
	
func leftInventoryMenuShift()-> void:
	currentPosition += 1
	currentPosition = currentPosition % 3
	setSectionCursor(currentPosition)
	pass
	
func rightInventoryMenuShift()-> void:
	currentPosition -= 1
	if(currentPosition == -1):
		currentPosition = 2
	setSectionCursor(currentPosition)
	pass
	
func setSectionCursor(CurrentPosition):
	ItemSection1.visible = false
	ItemSection2.visible = false
	ItemSection3.visible = false
	EquipSection.visible = false
	ConsumeableSection.visible = false
	KeySection.visible = false
	
	match CurrentPosition:
		0:
			ItemSection1.visible = true			
			EquipSection.visible = true
		1:
			ItemSection2.visible = true
			ConsumeableSection.visible = true
		2:
			ItemSection3.visible = true
			KeySection.visible = true
	shiftInventorySlot(0)
	pass
	
func shiftInventorySlot(x = 0):
	var ItemLists = ItemDetails.get_child(currentPosition)
	var columbSize = 5
	var maxsize = ItemLists.get_child_count() - (ItemLists.get_child_count() % columbSize) + columbSize
	var childCount = ItemLists.get_child_count() -1
	
	currentSlot += x
	if(abs(x) == columbSize):
		if(currentSlot >  childCount):
			currentSlot = currentSlot % columbSize
		elif(currentSlot < 0):
			currentSlot += maxsize
			while(currentSlot > childCount):
				currentSlot -= columbSize
	elif(abs(x) == 1):
		if(currentSlot >  childCount):
			currentSlot = 0
		elif(currentSlot < 0):
			currentSlot =  childCount
	else:
		if(currentSlot + x >  childCount):
			currentSlot = currentSlot % columbSize
	setCurrentItemCursor(currentPosition,currentSlot)
	
func setCurrentItemCursor(CurrentPosition,currentSlot):
	var ItemLists = ItemDetails.get_child(CurrentPosition)
	var childCount = ItemLists.get_child_count()
	var currentItem
	for i in range(0,childCount,1):
		if(currentSlot == i):
			ItemLists.get_child(i).show()
			currentItem = ItemLists.get_child(i).get_node("ItemSprite").getItem()
			DisplayItemData(currentItem)
		else:
			ItemLists.get_child(i).hide()
			
func getCurrentItemID():
	var ItemLists = ItemDetails.get_child(currentPosition)
	return ItemLists.get_child(currentSlot).get_child(1).getItem().getID()
	
func DisplayItemData(var currentItem :item):
	var ItemSprite = currentItem.getTexture()
	var ItemName = currentItem.getName()
	var ItemDescription = currentItem.getHoverText()
	ItemInfo.get_child(0).set_texture(ItemSprite)
	ItemInfo.get_child(1).set_text(ItemName)
	ItemInfo.get_child(2).set_text(ItemDescription)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
