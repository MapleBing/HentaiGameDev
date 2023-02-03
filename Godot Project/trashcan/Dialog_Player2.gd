extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file
export var dialogue_text = ""

var dialogues = []
var current_dialogue_id = 0
var dialogue_active = false

onready var dialogue = $NinePatchRect/dialogue
onready var id = $NinePatchRect/ID

func _ready():
	$NinePatchRect.visible = false
	
func play():
	if dialogue_active:
		return
	
	dialogues = load_dialogue()
	
	get_tree().paused = true
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
	if current_dialogue_id >= len(dialogues[dialogue_text]):
		$Timer.start()
		$NinePatchRect.visible = false
		get_tree().paused = false
		return
	
	$NinePatchRect/ID.text = dialogues[dialogue_text][current_dialogue_id]["name"]
	$NinePatchRect/dialogue.text = dialogues[dialogue_text][current_dialogue_id]["text"]

func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())

func _on_Timer_timeout():
	dialogue_active = false
	

