extends CanvasLayer

var buttonPress = false
#Collection of menu inputs that send a signal to the signal bus
func _process(delta: float) -> void:
	var x = 0
	if Input.is_action_just_pressed("in_game_menu"):
		SignalBus.emit_signal("setUpPause")
		pass
	elif Input.is_action_just_pressed("inventory_menu"):
		SignalBus.emit_signal("setUpInventory")
		pass
	elif Input.is_action_just_pressed("inventory_section_shiftRight"):
		SignalBus.emit_signal("inventoryMenuShiftRight")
		pass
	elif Input.is_action_just_pressed("inventory_section_shiftLeft"):
		SignalBus.emit_signal("inventoryMenuShiftLeft")
		pass	
	elif Input.is_action_just_pressed("inventory_menu_shiftUp"):
		x = -5
		SignalBus.emit_signal("inventorySlotShift", x)
	elif Input.is_action_just_pressed("inventory_menu_shiftDown"):
		x = 5
		SignalBus.emit_signal("inventorySlotShift", x)
	elif Input.is_action_just_pressed("inventory_menu_shiftRight"):
		x = 1
		SignalBus.emit_signal("inventorySlotShift", x)
	elif Input.is_action_just_pressed("inventory_menu_shiftLeft"):
		x = -1
		SignalBus.emit_signal("inventorySlotShift", x)
	elif Input.is_action_just_pressed("inventory_menu_confirm"):
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
