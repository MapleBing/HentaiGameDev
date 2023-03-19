extends Node2D
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var portrait = "none"
onready var portrait_animator = $AnimationPlayer
# Called when the node enters the scene tree for the first time.

func _ready():
	SignalBus.connect("portrait_right", self,"right_portrait")
	SignalBus.connect("portrait_left", self,"left_portrait")
	SignalBus.connect("portrait_none", self,"none_portrait")
	SignalBus.connect("restart_anim", self,"anim_restart")
	portrait_animator.play("none")
	
func right_portrait():
	portrait_animator.play("right")
	
func left_portrait():
	portrait_animator.play("left")
	
func none_portrait():
	portrait_animator.play("none")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
