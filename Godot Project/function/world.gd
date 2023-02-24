extends Node

#角色切換scene時重置位置
export(String, FILE) var dialogue_file
onready var resource = load(dialogue_file)
var call_dialog

func dialogue_deactivate(): # TL新加的，用來接signal
	get_tree().paused = false

func set_dialogue(dialogue_key):
	call_dialog = dialogue_key
	play(dialogue_file, dialogue_key)

func set_hSceneDialogue(hScene_file,dialogue_key):
	call_dialog = dialogue_key
	play(hScene_file, dialogue_key)

func _ready():
	SignalBus.connect("display_dialog", self, "set_dialogue")
	DialogueManager.connect("dialogue_finished", self, "dialogue_deactivate") #見上述func
	if ScenePos.from_scene != null:
		$YSort.get_node("MovingEntity").get_node("player").set_position(
			get_node("maps").get_node(ScenePos.from_scene + "Pos").position)

func play(dialogue_file, dialogue_key):
	get_tree().paused = true
	if File.new().file_exists(dialogue_file):
		DialogueManager.dialogue_box(call_dialog, resource)
	
