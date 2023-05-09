extends Node2D

var scene
var hScenes 
export(String, FILE) var hentai_scene
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("start_h_scene", self, "startHScene")
	SignalBus.connect("end_h_scene", self, "endHScene")
	
func startHScene(MonsterName):
	if hScenes != null:
		endHScene()
	scene = load(HSceneBus.getHScene(MonsterName))
	hScenes = scene.instance()
	add_child(hScenes)
func endHScene():
	hScenes.queue_free()
	hScenes = null
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
