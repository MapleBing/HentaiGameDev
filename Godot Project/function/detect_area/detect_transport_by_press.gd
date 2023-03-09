extends Area2D
var entered = false
export var autoEnter = false
var time = 0

func _on_detect_transport_body_entered(_body):
	entered = true
	print(get_parent().get_parent().name)

func _on_detect_transport_body_exited(_body):
	entered = false
	
func _ready():
	entered= false
	
func _process(delta):
	if time <= 0:
		entered = false
		time += delta
	if entered:
		ScenePos.from_scene = get_parent().get_parent().name
		if autoEnter:
			get_tree().change_scene("res://Map_land/" + self.name + ".tscn")
		elif Input.is_action_just_pressed("interact"):
			get_tree().change_scene("res://Map_land/" + self.name + ".tscn")
