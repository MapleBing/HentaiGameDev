extends KinematicBody2D

var RotateSpeed = 1
var Radius = 100
var _centre
var _angle = 0
#var offset
var velocity = Vector2.ZERO

func _ready():
	#set_process(true)
	_centre = global_position
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 5 
	elif Input.is_action_pressed("ui_left"):
		velocity.x += -5 
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 5 
	elif Input.is_action_pressed("ui_up"):
		velocity.y += -5 
		
	_angle += delta
	var offset = Vector2(cos(_angle), -sin(_angle)) * Radius
	#var offset = input_vector * Radius
	#var pos = _centre + offset
	self.set_position(offset)
	
	print(global_position)
