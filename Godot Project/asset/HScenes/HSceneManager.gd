extends Node2D

var scene
var hScenes 
export(String, FILE) var hentai_scene
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("h_scene", self, "openHScene")
	SignalBus.connect("h_scene_end", self, "endHScene")
	
func openHScene():
	scene = load("res://asset/H_Scenes/HentaiScene1.tscn")
	hScenes = scene.instance()
	add_child(hScenes)
func endHScene():
	hScenes.queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
