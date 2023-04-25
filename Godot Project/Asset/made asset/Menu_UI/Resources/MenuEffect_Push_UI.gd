extends Resource
var startingPosition = 0

static func TriggerEffect(node):
	if node.active == true:
		node.get_child(0).rect_position.x = -10
		print("Right")
		
	else:
		node.get_child(0).rect_position.x = 0
		print("Left")
