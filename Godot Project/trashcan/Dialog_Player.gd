extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var current_dialogue_id = 0
var dialogue_active = false

func _ready():
	$NinePatchRect.visible = false
	
func play():
	if dialogue_active:
		return
	
	dialogues = load_dialogue()
	
	player_off()
	dialogue_active = true
	$NinePatchRect.visible = true
	current_dialogue_id = -1
	next_line()
	
func _input(event):
	if not dialogue_active:
		return
	
	if event.is_action_pressed("interact"):
		next_line()
		
func next_line():
	current_dialogue_id += 1	
	if current_dialogue_id >= len(dialogues):
		$Timer.start()
		$NinePatchRect.visible = false
		player_on()
		return
	
	$NinePatchRect/name.text = dialogues[current_dialogue_id]["name"]
	$NinePatchRect/dialoog.text = dialogues[current_dialogue_id]["text"]

func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())

func _on_Timer_timeout():
	dialogue_active = false
	
func player_on():
	var player = get_tree().get_root().find_node("player", true, false)
	if player:
		player.set_active(true)
		
func player_off():
	var player = get_tree().get_root().find_node("player", true, false)
	if player:
		player.set_active(false)
