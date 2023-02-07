extends Control
onready var itemSprite = load("res://asset/Items/ItemSprite.tscn")
onready var itemInst = load("res://asset/Items/ItemSprite.tscn")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var consumeableObject = get_node("HBoxContainer2/InventoryContainer/VBoxContainer/Consumable Container")
	var currentItem = itemInst.instance()
	var currentItemSprite = itemSprite.instance()
	currentItemSprite
	consumeableObject.add_child(currentItem)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
