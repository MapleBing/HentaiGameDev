extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var hScene_0 = preload ("res://asset/character/Pixel Character/no_name chara/hSCENE_ERI.png")
var hScene_1 = preload ("res://asset/character/Pixel Character/no_name chara/CharacterHSceneSample.png")
var CurrentTexture = ""
onready var hScene_Animation = $AnimationPlayer
onready var hScene_sprite = $Sprite
var Speed = 1.0
var AnimName = "HScene"
var Restart = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	state_machine = $AnimationTree.get_child("perameters/playback")
	anim_text_set(hScene_0)
	hScene_Animation.play(AnimName)
	hScene_Animation.playback_speed = Speed
	connect_signalBus()
	
func connect_signalBus():
	SignalBus.connect("restart_anim", self, "anim_restart")
	SignalBus.connect("change_anim", self, "anim_change")
	SignalBus.connect("playspeed_anim", self, "anim_playspeed")
	SignalBus.connect("text_anim_set", self, "anim_text_set")
	
func anim_restart(restart):
	Restart = restart
	hScene_Animation.stop(Restart)
	hScene_Animation.play()
	
func anim_change(animName):
	AnimName = animName
	hScene_Animation.play(AnimName)
	
func anim_playspeed(speed):
	Speed = speed
	hScene_Animation.playback_speed = Speed
	if speed == 0:
		hScene_Animation.stop()
		hScene_Animation.play()
func anim_text_set(currentTexture):
	CurrentTexture = currentTexture
	match CurrentTexture:
		"hScene_0":
			CurrentTexture = hScene_0
		"hScene_1":
			CurrentTexture = hScene_1
			
	hScene_sprite.set_texture(CurrentTexture)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
