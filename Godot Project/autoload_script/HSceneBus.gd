extends Node

var monsterScene: String = ""
var currentItem : String = ""

func getHScene(MonsterName)-> String:
	match MonsterName: #Name, SpriteFilePath, +/Description"
		"slime":
			monsterScene = "res://Asset/Art/HScenes/AniCgs/EriXSlime_Sc.tscn"
		"erix_maya": 
			monsterScene = "res://Asset/Art/HScenes/StaticCgs/Stills/Cg_EriXMaya.png"
		"slime2": 
			monsterScene = "res://Asset/Art/HScenes/AniCgs/EriXSlime_Sc.tscn"
	return monsterScene



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
