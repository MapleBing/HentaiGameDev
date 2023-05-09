extends Control
onready var itemSlot = load("res://Asset/made asset/Menu_UI/Layouts/Prefabs/ItemSlot_UI.tscn")
var Items = ""
var currentPosition = 0;
var currentSlot = 0;
#Conncetions to local scene
onready var SectionMenu = $SectionBar/SectionMenu
#	Connections to the menu
onready var equipObject = $ItemDetails/EquipList.get_child(0)
onready var consumeableObject = $ItemDetails/ConsumeableList.get_child(0)
onready var keyObject = $ItemDetails/KeyList.get_child(0)
#	Connections to the UI assets for item and detial display
onready var ItemDetails = $ItemDetails
onready var ItemInfo = $ItemInfo

#	Refers to whether this current menu is active (connected: )
onready var active = false
var testAsset = preload("res://Asset/Items/Item_Resources/00_Test_I.tres")
func _ready():
	#Initiallize objects in stored Inventory
	getAllItems()
	DisplayItemData(getActiveItem())
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
			controlInventoryList(amount, keyObject)
			controlInventoryList(amount, consumeableObject)
			controlInventoryList(amount, equipObject)
			return
			
		if Input.is_action_just_pressed("Move_Left"):
			amount = -1
			controlInventoryList(amount, keyObject)
			controlInventoryList(amount, consumeableObject)
			controlInventoryList(amount, equipObject)
			return
			
func getAllItems():
	for itemObj in ItemBus.getAllItems():
		addItem(itemObj)
		
func getActiveItem():
	var activeItem = null
	activeItem = getCurrentItem(getCurrentSection())
	#if activeItem != null:
		#return activeItem
	return testAsset
func getCurrentItem (section = null):
	if section.visible == true:
		for node in section.get_children():
			if node.get_child(0).active == true:
				return node 
func getCurrentSection():
	for node in ItemDetails.get_children():
		if node.get_child(0).get_child(0).active == true:
			return node 
			
func controlInventoryList(x = 0, section = null):
	getCurrentItem(section).ShiftSelection(x)

func controlInventoryListRow(x = 0, section = null):
	getCurrentItem(section).ShiftSelectionRow(x)
	
func addItem(itemObj):
	var currentSlot: Node = itemSlot.instance()
	currentSlot.find_node("ItemSprite").currentItem = itemObj
	print(currentSlot.name)
	match itemObj.type:
			item.ItemTypes.EQUIPABLE:
				equipObject.add_child(currentSlot)
			item.ItemTypes.CONSUMEABLE:
				consumeableObject.add_child(currentSlot)
			item.ItemTypes.KEY:
				consumeableObject.add_child(currentSlot)
	
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
	
	for object in itemSection.get_children():
		currentItem = object.find_node("ItemSprite").currentItem
		print(itemID)
		print(currentItem.getQuantity())
		if currentItem.getID() == itemID:
			if currentItem.getQuantity() >= quantity:
				return true
	return false
	
func DisplayItemData(node = null):
	ItemInfo.ItemResorce = testAsset
	ItemInfo.DisplayItemData()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#
