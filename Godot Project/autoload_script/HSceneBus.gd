extends Node

var monsterScene: String = ""
var currentItem : String = ""

func getHScene(MonsterName)-> String:
	match MonsterName: #Name, SpriteFilePath, +/Description"
		"slime":
			monsterScene = "res://asset/HScenes/AniCgs/EriXSlimeHScene.tscn"
		"erix_maya": 
			monsterScene = "res://asset/HScenes/StaticCgs/EriXMayaHScene.tscn"
		"slime2": 
			monsterScene = "res://asset/HScenes/AniCgs/EriXSlimeHScene.tscn"
	return monsterScene



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
