extends KinematicBody2D

var rotation_speed = PI # or 180 degrees

func _physics_process(delta):
	var v = ship.global_position - global_position

	var angle = v.angle()
	var r = global_rotation

	var angle_delta = rotation_speed * delta

	angle = lerp_angle( r, angle, 1.0)

	angle = clamp(angle, r - angle_delta, r + angle_delta)

	global_rotation = angle
