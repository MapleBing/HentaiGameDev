extends Control
onready var itemSprite = load("res://asset/Items/ItemSlot_I.tscn")
var Items = ""
var currentPosition = 0;
var currentSlot = 0;

onready var SectionMenu = $SectionBar/SectionMenu

onready var equipObject = $ItemDetails/EquipList.get_child(0)
onready var consumeableObject = $ItemDetails/ConsumeableList.get_child(0)
onready var keyObject = $ItemDetails/KeyList.get_child(0)

onready var ItemDetails = $ItemDetails
onready var ItemInfo = $ItemInfo
onready var active = false
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
	
func _input(event):
	if self.visible == true:
		if Input.is_action_just_pressed("Tab_Right"):
			for node in SectionMenu.get_children():
				if node.active == true:
					node.ShiftSelection(1)
					return
		if Input.is_action_just_pressed("Tab_Left"):
			for node in SectionMenu.get_children():
				if node.active == true:
					node.ShiftSelection(-1)
					return
					
		var amount = 0
		if Input.is_action_just_pressed("Move_Up"):
			amount = 1
			controlInventoryListRow(amount, keyObject)
			controlInventoryListRow(amount, consumeableObject)
			controlInventoryListRow(amount, equipObject)
			return
			
		if Input.is_action_just_pressed("Move_Down"):
			amount = -1
			controlInventoryListRow(amount, keyObject)
			controlInventoryListRow(amount, consumeableObject)
			controlInventoryListRow(amount, equipObject)
			return
			
		if Input.is_action_just_pressed("Move_Right"):
			amount = 1
			print("")
			print("right")
			controlInventoryList(amount, keyObject)
			controlInventoryList(amount, consumeableObject)
			controlInventoryList(amount, equipObject)
			return
			
		if Input.is_action_just_pressed("Move_Left"):
			amount = -1
			print("")
			print("Left")
			controlInventoryList(amount, keyObject)
			controlInventoryList(amount, consumeableObject)
			controlInventoryList(amount, equipObject)
			return

func controlInventoryList(x = 0, section = null):
	if section.visible == true:
		for node in section.get_children():
			if node.active == true:
				node.ShiftSelection(x)
				return

func controlInventoryListRow(x = 0, section = null):
	if section.visible == true:
		for node in section.get_children():
			if node.active == true:
				node.ShiftRow(x)
				return

func confirmInventoryMenu():
	print_debug("________")
	print_debug(String(currentPosition)+ " " + String(currentSlot))
	addItem(getCurrentItemID(),-1)
	pass
	
func addItem(itemID = 0,quantity = 0):
	var currentItemSprite: Node = itemSprite.instance()
	currentItemSprite.find_node("ItemSprite").setUpItemSprite(itemID,quantity)
	var currentObject
	
func checkForItem(itemID = 0,quantity = 0):
	var result  = false
	if runThroughList(equipObject, itemID, quantity):
		result = true
	if runThroughList(keyObject, itemID, quantity):
		result = true
	if runThroughList(consumeableObject, itemID, quantity):
		result = true
	SignalBus.emit_signal("get_item_result", result)

func runThroughList(itemSection, itemID = 0, quantity = 0):
	#get itemSection.
	var currentItem = false
	itemSection.get_child_count()
	
	for object in keyObject.get_children():
		currentItem = object.get_child(1).getItem()
		print(itemID)
		print(currentItem.getQuantity())
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
		print(groupNode.name)
		groupNode.add_child(fillInventory(itemPosition, tempItems))
	
func fillInventory(ItemPosition, TempItems):
	var itemId = TempItems.get_slice(",", ItemPosition).to_int()
	var currentItemSprite: Node = itemSprite.instance()
	currentItemSprite.find_node("ItemSprite").setUpItemSprite(itemId,1)
	return currentItemSprite
	
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
