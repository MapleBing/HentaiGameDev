extends Area2D

var checking = false
onready var parent = get_parent()

func _on_EnemyHitBox_body_entered(body: Node) -> void:
	if(!parent.recovery):
		parent.nearPlayer = true
	checking = false
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_pressed("Interact"):
		checking = true
