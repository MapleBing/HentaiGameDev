extends Control
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var menu
var currentMenu
export(String, FILE) var saveScene
export(String, FILE) var loadScene
export(String, FILE) var optionScene
export(String, FILE) var mainMenuScene
onready var MenuList = $BaseMenu/MenuList

# Called when the node enters the scene tree for the first time.
func _input(event):
	if Input.is_action_just_pressed("Toggle_Inventory") and !get_child(0).is_visible():
		resetMenu()
	elif Input.is_action_just_pressed("Toggle_Inventory"):
		_on_resume_pressed()
	if Input.is_action_just_pressed("ui_down"):
		for node in MenuList.get_children():
			if node.active == true:
				node.ShiftSelection(1)
				break
	if Input.is_action_just_pressed("ui_up"):
		for node in MenuList.get_children():
			if node.active == true:
				node.ShiftSelection(-1)
				break
func CheckCurrentMenu():
	queue_free()
func _on_resume_pressed() -> void:
	queue_free()
	pass # Replace with function body.
	
func _on_saveGame_pressed() -> void:
	menu = load(saveScene)
	changeMenu()
	
func _on_loadGame_pressed() -> void:
	menu = load(loadScene)
	changeMenu()

func _on_options_pressed() -> void:
	menu = load(optionScene)
	changeMenu()
	pass # Replace with function body.
func _on_quitToMenu_pressed() -> void:
	get_tree().quit()
	
func _on_quitToDesktop_pressed() -> void:
	get_tree().quit()
	
	pass # Replace with function body.






func changeMenu():
	currentMenu = menu.instance()
	add_child(currentMenu)
	get_child(0).set_visible(false)
func resetMenu():
	currentMenu = menu.instance()
	get_child(0).set_visible(true)
	get_child(1).queue_free()


