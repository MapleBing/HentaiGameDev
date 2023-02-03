extends Area2D

var entered = false

func _ready() -> void:
	pass
	
func _on_detect_transport_body_entered(_body):
	entered = true
	print(self.name)


func _process(delta):
	if entered == true:
		ScenePos.from_scene = get_parent().get_parent().name
		get_tree().change_scene("res://Map_land/" + self.name + ".tscn")
