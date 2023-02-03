extends Node2D

var d = 0
var radius = 150
#var speed = 60


onready var idle_position = Vector2(cos(0) , sin(0) ) * radius
onready var target_position = Vector2(cos(0) , sin(0) ) * radius


func _physics_process(delta):
	
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized() 
	#print(d)
	
	if input_vector != Vector2.ZERO:
		idle_position = Vector2(cos(input_vector.angle()), sin(input_vector.angle())) * radius
		target_position = Vector2(cos(input_vector.angle()), sin(input_vector.angle())) * radius
		
		#
		var v = target_position - global_position  
		var angle = v.angle()  
		var r = global_position.angle_to(position)
		var angle_delta = PI * delta  
		angle = lerp_angle( r, angle, 1.0)  
		angle = clamp(angle, r - angle_delta, r + angle_delta)  
		position = radius * Vector2(cos(angle), sin(angle))
		#
		
		#position = target_position
		

	else:
		#target_position 轉向 idle_position
		position = target_position
		
		


