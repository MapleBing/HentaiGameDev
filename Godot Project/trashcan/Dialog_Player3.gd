extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var dialog_index = 0
var dialogue_active = false
var dialogue_text

func set_button_visible(x):
	$button.visible = x

func set_dialogue_text(now):
	dialogue_text = now
	play()

func _ready():
	$NinePatchRect.visible = false
	$button.visible = false
	SignalBus.connect("display_dialog", self, "set_dialogue_text")
	SignalBus.connect("display_dialog_button", self, "set_button_visible")

func play():
	if dialogue_active:
		return
	
	dialogues = load_dialogue()
	
	get_tree().paused = true
	dialogue_active = true
	$NinePatchRect.visible = true
	dialog_index = -1
	$button.visible = false
	next_line()
	
func _input(event):
	if not dialogue_active:
		return
	
	if event.is_action_pressed("interact"):
		next_line()
		print("button:",$button.visible)
		
func next_line():
	dialog_index += 1	
	
	if dialog_index >= len(dialogues[dialogue_text]):
		$Timer.start()
		$NinePatchRect.visible = false
		get_tree().paused = false
		$button.visible = true
		return
	
	$NinePatchRect/ID.bbcode_text = dialogues[dialogue_text][dialog_index]["name"]
	$NinePatchRect/dialogue.bbcode_text = dialogues[dialogue_text][dialog_index]["text"]

func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		return parse_json(file.get_as_text())

func _on_Timer_timeout():
	dialogue_active = false
	

