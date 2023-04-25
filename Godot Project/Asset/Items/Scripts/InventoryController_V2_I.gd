extends Control
onready var itemSprite = load("res://asset/Items/ItemSlot_I.tscn")
var Items = ""
var currentPosition = 0;
var currentSlot = 0;

onready var SectionMenu = $SectionBar/SectionMenu

onready var equipObject = $ItemDetails/EquipItems
onready var keyObject = $ItemDetails/KeyItems
onready var consumeableObject = $ItemDetails/ConsumeableItems
onready var EquipSection = $ItemDetails/EquipItems
onready var ConsumeableSection = $ItemDetails/ConsumeableItems
onready var KeySection = $ItemDetails/KeyItems
onready var ItemDetails = $ItemDetails
onready var ItemInfo = $ItemInfo

func _ready():
	#Initiallize objects in stored Inventory
	setGroup("Equip(1,1,1)",equipObject)
	setGroup("Key(1,1)",keyObject)
	setGroup("Consumeable(1)",consumeableObject)
	#Change current menu
	SignalBus.connect("inventoryMenuShiftRight", self, "leftInventoryMenuShift")
	SignalBus.connect("inventoryMenuShiftLeft", self, "rightInventoryMenuShift")
	#Move Cursor
	SignalBus.connect("inventorySlotShift", self, "shiftInventorySlot")
	#interact with item
	SignalBus.connect("inventoryMenuConfirm", self, "confirmInventoryMenu")
	#check for item
	SignalBus.connect("check_for_item", self, "checkForItem")
	
	shiftInventorySlot(0)
	
func _input(event):
	if Input.is_action_just_pressed("Tab_Right"):
		for node in SectionMenu.get_children():
			if node.active == true:
				node.ShiftSelection(1)
				break
	if Input.is_action_just_pressed("Tab_Left"):
		for node in SectionMenu.get_children():
			if node.active == true:
				node.ShiftSelection(-1)
				break

		
func confirmInventoryMenu():
	print_debug("________")
	print_debug(String(currentPosition)+ " " + String(currentSlot))
	addItem(getCurrentItemID(),-1)
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
	
func checkForItem(itemID = 0,quantity = 0):
	var result  = false
	if runThroughList(EquipSection, itemID, quantity):
		result = true
	if runThroughList(KeySection, itemID, quantity):
		result = true
	if runThroughList(ConsumeableSection, itemID, quantity):
		result = true
	SignalBus.emit_signal("get_item_result", result)

func runThroughList(itemSection, itemID = 0, quantity = 0):
	#get itemSection.
	var currentItem = false
	KeySection.get_child_count()
	print("checking")
	for object in KeySection.get_children():
		currentItem = object.get_child(1).getItem()
		print(itemID)
		print(currentItem.getQuantity() )
		if currentItem.getID() == itemID:
			if currentItem.getQuantity() >= quantity:
				return true
	return false
func setGroup(inventoryGroup = "", groupNode = null):
	var tempItems = inventoryGroup
	var groupCategory = inventoryGroup.get_slice("(",0)
	tempItems = "(" + tempItems
	tempItems.lstrip(groupCategory + "(")
	tempItems.rstrip(")")
	for itemPosition in range(0,tempItems.count(",")+1,+1):
		groupNode.add_child(fillInventory(itemPosition, tempItems))
	
func fillInventory(ItemPosition, TempItems):
	var itemId = TempItems.get_slice(",", ItemPosition).to_int()
	var currentItemSprite: Node = itemSprite.instance()
	currentItemSprite.find_node("ItemSprite").setUpItemSprite(itemId,1)
	return currentItemSprite
	
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
