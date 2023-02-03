extends Light2D

var RotateSpeed = PI * 3
var Radius = 1
var target_position

func _ready():
	position = Vector2(cos(0), -sin(0)) * Radius
	target_position = position

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		target_position = input_vector * Radius
		
		var target_angle = target_position.angle()
		var previous_angle = position.angle()
		var angle_delta = RotateSpeed * delta
		target_angle = lerp_angle(previous_angle, target_angle, 1.0)
		target_angle = clamp(target_angle, previous_angle - angle_delta, previous_angle + angle_delta)
		position = Vector2(cos(target_angle), sin(target_angle)) * Radius

		if (Vector2.RIGHT.rotated(global_rotation) - Vector2.RIGHT.rotated(target_angle)).length() == 2:
			target_angle = lerp_angle(previous_angle, target_angle + angle_delta, 1.0)
		else:
			target_angle = lerp_angle(previous_angle, target_angle, 1.0) 
		
		target_angle = lerp_angle(previous_angle, target_angle, 1.0) 
		global_rotation = target_angle
		
