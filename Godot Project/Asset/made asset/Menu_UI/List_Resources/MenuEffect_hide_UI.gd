extends Resource

static func TriggerEffect(node):
	if node.active == true:
		node.get_child(0).modulate = Color(1,1,1, 1)
	else:
		node.get_child(0).modulate = Color(1,1,1, 0)
