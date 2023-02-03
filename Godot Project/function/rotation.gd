extends Light2D

var RotateSpeed = PI * 3

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		var target_angle = input_vector.angle()
		var previous_angle = global_rotation
		var angle_delta = RotateSpeed * delta       
		
		if (Vector2.RIGHT.rotated(global_rotation) - input_vector).length() == 2:
			target_angle = lerp_angle(previous_angle, target_angle + angle_delta, 1.0) 
		else:
			target_angle = lerp_angle(previous_angle, target_angle, 1.0) 
		target_angle = clamp(target_angle, previous_angle - angle_delta, previous_angle + angle_delta)
		global_rotation = target_angle
