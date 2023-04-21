extends CanvasLayer

var buttonPress = false
#Collection of menu inputs that send a signal to the signal bus
func _input(event) -> void:
	var x = 0
	if Input.is_action_just_pressed("Toggle_Menu"):
		SignalBus.emit_signal("setUpPause")
		pass
	elif Input.is_action_just_pressed("Toggle_Inventory"):
		SignalBus.emit_signal("setUpInventory")
		pass
	elif Input.is_action_just_pressed("Tab_Right"):
		SignalBus.emit_signal("inventoryMenuShiftRight")
		pass
	elif Input.is_action_just_pressed("Tab_Left"):
		SignalBus.emit_signal("inventoryMenuShiftLeft")
		pass	
	elif Input.is_action_just_pressed("Move_Up"):
		x = -5
		SignalBus.emit_signal("inventorySlotShift", x)
	elif Input.is_action_just_pressed("Move_Down"):
		x = 5
		SignalBus.emit_signal("inventorySlotShift", x)
	elif Input.is_action_just_pressed("Move_Right"):
		x = 1
		SignalBus.emit_signal("inventorySlotShift", x)
	elif Input.is_action_just_pressed("Move_Left"):
		x = -1
		SignalBus.emit_signal("inventorySlotShift", x)
	elif Input.is_action_just_pressed("Interact"):
		SignalBus.emit_signal("inventoryMenuConfirm")
	 # Replace with function body.

# Hoping to replace the code above with the code below
#var buttonPress = false
#func _unhandled_key_input(event) -> void:
#	if event.is_action_pressed("in_game_menu") and get_child(0).get_child_count() == 0:
#		buttonPress = true
#		print_debug()
#		SignalBus.emit_signal("setUpPause")
#
#	elif event.is_action_pressed("in_game_menu") and get_child(0).get_child_count() == 0:
#		buttonPress = false
