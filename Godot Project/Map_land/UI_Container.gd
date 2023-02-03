extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export(String, FILE) var Pause_Menu
var scene
var menu
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("setUpPause", self, "pauseSetUp")
	pass # Replace with function body.
	
func pauseSetUp():
	scene = load(Pause_Menu)
	menu = scene.instance()
	add_child(menu)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
