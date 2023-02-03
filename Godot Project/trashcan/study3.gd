extends Node2D

var radius = 100
#var rotate = 50

onready var idle_position = Vector2(cos(0) , sin(0) ) * radius

func _ready():
	position = idle_position

func _process(delta):
	
	#var r = rotate * delta
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() 
		
	if input_vector != Vector2.ZERO:
		
		position = Vector2(cos(input_vector.angle())  , sin(input_vector.angle()) ) * radius
		#position = Vector2(cos(input_vector.angle())  , sin(input_vector.angle()) ) * radius
		
	


