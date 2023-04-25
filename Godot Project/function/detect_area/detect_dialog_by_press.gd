extends Area2D

export var dialog_key = ""
export(String, FILE) var dialogue_file
var area_active = false
onready var parent = get_parent()
#sends
func _input(event):
	if area_active and event.is_action_pressed("Interact") and !parent.talking:
		parent.update_direction()
		parent.talking = true
		SignalBus.emit_signal("display_dialogue", dialogue_file, dialog_key)
		

func _on_detect_dialog_by_press_2_body_entered(body):
	area_active = true
	SignalBus.emit_signal("display_dialog_button",true)
	
func _on_detect_dialog_by_press_2_body_exited(body):
	area_active = false
	SignalBus.emit_signal("display_dialog_button",false)
