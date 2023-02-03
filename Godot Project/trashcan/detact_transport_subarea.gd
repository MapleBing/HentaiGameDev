extends Area2D

export var path_to_player: NodePath
onready var player = get_node(path_to_player)


func _on_Area2D_body_entered(_body):
	print("get_parent().name"+get_parent().name)
	
	player.set_position(get_parent().position)
