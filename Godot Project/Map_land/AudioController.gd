extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var mute = false
onready var AudioPlayer = $BGMPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !mute:
		AudioPlayer.play()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
