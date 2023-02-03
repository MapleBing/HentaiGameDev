extends Area2D
var entered = false


func _on_detect_transport_body_entered(_body):
	entered = true
	print(get_parent().get_parent().name)

func _on_detect_transport_body_exited(_body):
	entered = false
	

func _process(delta):
	if entered == true:
		ScenePos.from_scene = get_parent().get_parent().name
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene("res://Map_land/" + self.name + ".tscn")
