extends Resource
class_name HideUI
var active = true
func TriggerEffect(node):
	print("test")
	if node.active == true:
		node.modulate = Color(1,1,1, 1)
		node.get_tree()
	else:
		node.modulate = Color(1,1,1, 0)
