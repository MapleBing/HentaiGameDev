extends Control


var scene
var minigame 
export(String, FILE) var hentai_scene
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("setUpFishingGame", self, "fishingGameSetUp")
	SignalBus.connect("setUpEndGame", self, "endGameSetUp")


func fishingGameSetUp():
	scene = load("res://addons/FishingMinigame/fishing_game.tscn")
	minigame = scene.instance()
	add_child(minigame)
	SignalBus.emit_signal("portrait_none")
	SignalBus.emit_signal("h_scene")
	SignalBus.emit_signal("text_anim_set","hScene_0")
	
func endGameSetUp():
	SignalBus.emit_signal("h_scene_end")
	minigame.queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
