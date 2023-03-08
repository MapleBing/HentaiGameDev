extends Node

#角色切換scene時重置位置
export(String, FILE) var dialogue_file
var current_file


func set_dialogue(Dialogue_key):
	current_file = load(dialogue_file)
	play(dialogue_file, Dialogue_key)
	
func displayEnemyDialogue(HScene_file,Dialogue_key):
	current_file = load(HScene_file)
	play(HScene_file, Dialogue_key)

func _ready():
	SignalBus.connect("display_dialog", self, "set_dialogue")
	DialogueManager.connect("dialogue_finished", self, "dialogue_deactivate") #見上述func
	SignalBus.connect("display_enemy_hscene", self, "displayEnemyDialogue")
	if ScenePos.from_scene != null:
		$YSort.get_node("MovingEntity").get_node("player").set_position(
			get_node("maps").get_node(ScenePos.from_scene + "Pos").position)

func play(Dialogue_file, Dialogue_key):
	get_tree().paused = true
	if File.new().file_exists(Dialogue_file):
		DialogueManager.dialogue_box(Dialogue_key, current_file)
		
func dialogue_deactivate(): # TL新加的，用來接signal
	get_tree().paused = false
