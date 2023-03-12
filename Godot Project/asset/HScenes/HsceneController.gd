extends Node2D

var CurrentTexture = ""
onready var hScene_Animation = $AnimationPlayer
onready var hScene_Effect = $EffectPlayer
onready var hScene_sprite = $Sprites/Sprite
var Speed = 1.0
var AnimNames
var currentAnimName = ""
var Restart = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	state_machine = $AnimationTree.get_child("perameters/playback")
	AnimNames = hScene_Animation.get_animation_list()
	currentAnimName = AnimNames[0]
	update()
	connect_signalBus()
	
func update():
	if  hScene_Animation.get_animation(currentAnimName) != null:
		hScene_Animation.play(currentAnimName)
		hScene_Animation.playback_speed = Speed
		
	elif  hScene_Effect.get_animation(currentAnimName) != null:
		hScene_Effect.play(currentAnimName)
		hScene_Effect.playback_speed = Speed
	
func connect_signalBus():
	SignalBus.connect("restart_anim", self, "anim_restart")
	SignalBus.connect("change_anim", self, "anim_change")
	SignalBus.connect("playspeed_anim", self, "anim_playspeed")
	
func anim_restart(restart):
	Restart = restart
	hScene_Animation.stop(Restart)
	hScene_Animation.play()
	
func anim_change(animName):
	currentAnimName = animName
	update()

func anim_playspeed(speed):
	Speed = speed
	hScene_Animation.playback_speed = Speed
	if speed == 0:
		hScene_Animation.stop()
		hScene_Animation.play()
