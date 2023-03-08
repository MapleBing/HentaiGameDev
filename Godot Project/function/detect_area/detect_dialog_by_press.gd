extends Area2D

export var dialog_key = ""
var area_active = false
var parent = get_parent()
func _input(event):
	if area_active and event.is_action_pressed("interact"):
		print ("fkku")
		SignalBus.emit_signal("display_dialog",dialog_key)
		

func _on_detect_dialog_by_press_2_body_entered(body):
	area_active = true
	SignalBus.emit_signal("display_dialog_button",true)

func _on_detect_dialog_by_press_2_body_exited(body):
	area_active = false
	SignalBus.emit_signal("display_dialog_button",false)
