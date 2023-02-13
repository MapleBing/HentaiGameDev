extends CanvasLayer

var buttonPress = false
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("in_game_menu"):
		SignalBus.emit_signal("setUpPause")
		
	elif Input.is_action_just_pressed("inventory_menu"):
		SignalBus.emit_signal("setUpInventory")
	pass # Replace with function body.

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
