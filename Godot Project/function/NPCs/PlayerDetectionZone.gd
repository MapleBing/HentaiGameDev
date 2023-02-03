extends Node

#var player = null
onready var parent = get_parent()

func _on_PlayerDetectionZone_body_entered(body):
	parent.player = body

func _on_PlayerDetectionZone_body_exited(body):
	parent.player = null
