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
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#input_vector = input_vector.normalized()
	
	_angle += RotateSpeed * delta
	var offset = Vector2(cos(_angle), -sin(_angle)) * Radius
	#var offset = input_vector * Radius
	#var pos = _centre + offset
	self.set_position(offset)
	
	print(global_position)
