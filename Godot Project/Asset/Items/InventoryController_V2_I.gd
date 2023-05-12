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
var EquipIcon = preload("res://Asset/Items/Item_Resources/00_Test_I.tres")
var ConsumeableIcon = preload("res://Asset/Items/Item_Resources/21_Potion_Health_I.tres")
var KeyIcon = preload("res://Asset/Items/Item_Resources/10_EriKey_I.tres")
func _ready():
	#Initiallize objects in stored Inventory
	getAllItems()
	updateIcon(SectionMenu.get_child(0), EquipIcon)
	updateIcon(SectionMenu.get_child(1), ConsumeableIcon)
	updateIcon(SectionMenu.get_child(2), KeyIcon)
	#interact with item
	SignalBus.connect("inventoryMenuConfirm", self, "confirmInventoryMenu")
	#check for item
	SignalBus.connect("check_for_item", self, "checkForItem")

func updateIcon(currentSection , icon):
	currentSection.get_child(1).currentItem = icon
	print(icon)
	currentSection.get_child(1).updateItem()
	
func _input(event):
	#if the inventory is visiable 
	if self.visible == true:
		#the active node will shift the selection left or right
		if Input.is_action_just_pressed("Tab_Right"):
			for node in SectionMenu.get_children():
				if node.active == true:
					node.ShiftSelection(1)
					break
			for node in ItemDetails.get_children():
				if node.active == true:
					node.ShiftSelection(1)
					return
		if Input.is_action_just_pressed("Tab_Left"):
			for node in SectionMenu.get_children():
				if node.active == true:
					node.ShiftSelection(-1)
					break
			for node in ItemDetails.get_children():
				print(node.name)
				if node.active == true:
					print("working")
					node.ShiftSelection(-1)
					return
					
		var amount = 0
		if Input.is_action_just_pressed("Move_Up"):
			amount = 1
			for node in ItemDetails.get_children():
				if node.active == true:
					controlInventoryListRow(amount, node)
			return
			
		if Input.is_action_just_pressed("Move_Down"):
			amount = -1
			for node in ItemDetails.get_children():
				if node.active == true:
					controlInventoryListRow(amount, node)
			return
			
		if Input.is_action_just_pressed("Move_Right"):
			amount = 1
			var node = getCurrentItem()
			controlInventoryList(amount, node)
			return
			
		if Input.is_action_just_pressed("Move_Left"):
			amount = -1
			var node = getCurrentItem()
			controlInventoryList(amount, node)
			return
		DisplayItemData(getActiveItem())
func getAllItems():
	for itemObj in ItemBus.getAllItems():
		addItem(itemObj)
		
func getActiveItem():
	var activeItem = null
	activeItem = getCurrentItem()
	#if activeItem != null:
		#return activeItem
	return activeItem
func getCurrentItem (section = getCurrentSection()):
	if section.visible == true:
		for node in section.get_child(0).get_children():
			if node.active == true:
				return node 
func getCurrentSection():
	for node in ItemDetails.get_children():
		if node.active == true:
			return node 
			
func controlInventoryList(x = 0, section = null):
	getCurrentItem().ShiftSelection(x)

func controlInventoryListRow(x = 0, section = null):
	getCurrentItem().ShiftSelectionRow(x)
	
func addItem(itemObj):
	var currentSlot: Node = itemSlot.instance()
	currentSlot.find_node("ItemSprite").currentItem = itemObj
	currentSlot.find_node("ItemSprite").updateItem()
	
	match itemObj.type:
			item.ItemTypes.EQUIPABLE:
				equipObject.add_child(currentSlot)
			item.ItemTypes.CONSUMEABLE:
				consumeableObject.add_child(currentSlot)
			item.ItemTypes.KEY:
				keyObject.add_child(currentSlot)

func checkForItem(itemID = 0, quantity = 0):
	var result = false
	var currentItem = false
	for section in ItemDetails.get_children():
		for object in section.get_child(0).get_children():
			currentItem = object.find_node("ItemSprite").currentItem
			if currentItem.id == itemID:
				if object.find_node("ItemSprite").quantity >= quantity or currentItem.stackable == false:
					result = true
					break
	SignalBus.emit_signal("get_item_result", result)
	
func DisplayItemData(node = null):
	ItemInfo.ItemResorce = node.find_node("ItemSprite").currentItem
	ItemInfo.DisplayItemData()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#
