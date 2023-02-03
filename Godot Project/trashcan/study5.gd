extends Node2D

var d = 0
var radius = 150
var speed = 2
var idle_position = Vector2(cos(0) , sin(0) ) * radius

func _ready():
	position = idle_position

func _physics_process(delta):
	
	#position = Vector2(cos(d * speed) * radius,sin(d * speed) * radius)
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 5 
	elif Input.is_action_pressed("ui_left"):
		velocity.x += -5 
	elif Input.is_action_pressed("ui_down"):
		velocity.y += 5 
	elif Input.is_action_pressed("ui_up"):
		velocity.y += -5 
	#else:
		#velocity.x = 0
		#velocity.y = 0
	#velocity.normalized()
	
	if velocity != Vector2.ZERO:
		d += delta
		var rotation_angle = self.position - global_position
		var angle = velocity.angle_to(rotation_angle)
				
		position = Vector2(cos(angle * d)  , sin(angle * d) ) * radius
	
