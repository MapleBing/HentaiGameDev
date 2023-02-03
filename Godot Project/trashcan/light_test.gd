extends LightOccluder2D

onready var cull_mode = self.get("parameters/cullmode")

func _input(event):
	if event.is_action_pressed("interact"):
		cull_mode = 1
	else:
		cull_mode = 0
