extends Area2D

func _process(delta):
	if len(get_overlapping_bodies()) > 0:
		get_node("button").visible = true
	else:
		get_node("button").visible = false

func _input(event):
	if event.is_action_pressed("interact") and len(get_overlapping_bodies()) > 0:
		find_and_use_dialogue()
		print("fkYALL")


func find_and_use_dialogue():
	var dialogue_player = get_node_or_null("Dialogue_1")
	
	if dialogue_player:
		dialogue_player.play()



