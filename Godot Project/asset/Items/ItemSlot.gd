extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var panel = $Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func hide():
	panel.visible = false
	
func show():
	panel.visible = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
