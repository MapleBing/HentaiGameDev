extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var dialogues = []
var dialog_index = 0
var dialogue_text
var dialogue_active = false
var finished = false

func set_button_visible(x):
	$button.visible = x

func set_dialogue_text(now):
	dialogue_text = now
	print("fkkkkkkyee")
	play()

func _ready():
	$NinePatchRect.visible = false
	$button.visible = false
	SignalBus.connect("display_dialog", self, "set_dialogue_text")
	SignalBus.connect("display_dialog_button", self, "set_button_visible")

func _input(event):
	if not dialogue_active:
		return
	
	if Input.is_action_just_pressed("interact") and finished == true:
		next_line()
		return
		
	if Input.is_action_just_pressed("interact") and finished == false:
		$Tween.remove_all()
		$NinePatchRect/dialogue.percent_visible = 1
		finished = true
		
func play():
	if dialogue_active:
		return
	
	dialogues = load_dialogue()
	$NinePatchRect.visible = true
	$button.visible = false
	get_tree().paused = true
	dialogue_active = true
	dialog_index = -1 
	next_line()

func next_line():
	dialog_index += 1
	
	if dialog_index >= len(dialogues[dialogue_text]) and finished == true:
		$Timer.start()
		$NinePatchRect.visible = false
		get_tree().paused = false
		$button.visible = true
		return
	
	$NinePatchRect/ID.bbcode_text = dialogues[dialogue_text][dialog_index]["name"]
	
	$NinePatchRect/dialogue.bbcode_text = dialogues[dialogue_text][dialog_index]["text"]
	$NinePatchRect/dialogue.percent_visible = 0
	var text_speed = dialogues[dialogue_text][dialog_index]["text"].length() 
	$Tween.interpolate_property(
	$NinePatchRect/dialogue,"percent_visible",0,1,text_speed,
	Tween.TRANS_LINEAR,Tween.EASE_IN_OUT
	)
	print("startTTTTTT")
	$Tween.start()

func load_dialogue():
	var file = File.new()
	if File.new().file_exists(dialogue_file):
		file.open(dialogue_file, file.READ)
		print(file)
		return parse_json(file.get_as_text())
		
func _on_Timer_timeout():
	dialogue_active = false
	
func _on_Tween_tween_completed(object, key):
	finished = true
	print("completed")
func _on_Tween_tween_started(object, key):
	finished = false
	print("started")
