extends Resource
<<<<<<< HEAD
class_name HideUI

static func TriggerEffect(node):
	print("test")
	
	if node.active == true:
		node.get_child(0).modulate= Color(1,1,1, 1)
		node.active = false
		#node.modulate = Color(1,1,1, 1)
		node.get_tree()
	else:
		node.get_child(0).modulate= Color(1,1,1, 0)
		node.active = true
		#node.modulate = Color(1,1,1, 0)
=======
class_name MenuEffect

func TriggerEffect(node):
	node.visable = !node.visable
>>>>>>> parent of f0f8673 (Godot Update)
