extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export(String, FILE) var Pause_Menu
export(String, FILE) var Inventory_Menu
var scene
var menu
# Called when the node enters the scene tree for the first time.

func _input(event) -> void:
	if Input.is_action_just_pressed("Toggle_Menu"):
		changeMenu(Pause_Menu)
		pass
	elif Input.is_action_just_pressed("Toggle_Inventory"):
		changeMenu(Inventory_Menu)
		pass
func pauseSetUp():
	changeMenu(Pause_Menu)
	
func inventorySetUp():
	changeMenu(Inventory_Menu)
	
func changeMenu(currentMenu):
	if(get_child_count() == 0):
		scene = load(currentMenu)
		menu = scene.instance()
		add_child(menu)
		get_tree().paused = true
	else:
		get_child(0).queue_free()
		get_tree().paused = false
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
