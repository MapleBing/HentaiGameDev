extends Area2D


export var dialog_key = ""
var area_active = false

func _input(event):
	if area_active:
		# print ("fkku") # 我感覺我們不需要這東西了lol
		SignalBus.emit_signal("display_dialog",dialog_key)

func _on_CollisionShape2D_child_entered_tree(node):
	area_active = true
	SignalBus.emit_signal("display_dialog_button",true)
	pass # Replace with function body.

func _on_CollisionShape2D_child_exiting_tree(node):
	area_active = false
	SignalBus.emit_signal("display_dialog_button",false)
	pass # Replace with function body.
