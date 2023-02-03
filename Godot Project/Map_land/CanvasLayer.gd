extends CanvasLayer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
# Called when the node enters the scene tree for the first time.
var buttonPress = false
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel") and get_child(0).get_child_count() == 0:
		buttonPress = true
		SignalBus.emit_signal("setUpPause")
			
	elif Input.is_action_just_pressed("ui_cancel")and get_child(0).get_child_count() == 0:
		buttonPress = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
