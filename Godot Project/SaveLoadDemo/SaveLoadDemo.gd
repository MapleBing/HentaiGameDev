# Takes care of loading or creating a new save game and provides appropriate
# resources to the user interface and the player.
extends Node2D

# We always keep a reference to the SaveGame resource here to prevent it from unloading.
var _save: SaveGame

export var player : NodePath
#export var ui_inventory : NodePath
export var ui_save_panel : NodePath
export var ui_info_display : NodePath


onready var _player = get_node(player)
#onready var _ui_inventory = get_node(ui_inventory)
onready var _ui_save_panel = get_node(ui_save_panel)
onready var _ui_info_display = get_node(ui_info_display)


func _ready() -> void:
	_ui_save_panel.connect("reload_requested", self, "_create_or_load_save")
	_ui_save_panel.connect("save_requested", self, "_save_game")
	
	# And the start of the game or when pressing the load button, we call this
	# function. It loads the save data if it exists, otherwise, it creates a 
	# new save file.
		#_create_or_load_save()
	# This function offsets the camera when the inventory menu is open to not 
	# hide the player.
	#_player.toggle_camera_offset(_ui_inventory.visible)

#func _physics_process(delta: float) -> void:
	#_ui_info_display.update_player_position(_player.global_position)


func _create_or_load_save() -> void:
	if SaveGame.save_exists():
		_save = SaveGame.load_savegame()
	else:
		_save = SaveGame.new()
		#_save.inventory.add_item("healing_gem", 3)
		#_save.inventory.add_item("sword", 1)

		_save.map_name = "map_1"
		_save.global_position = _player.global_position

		_save.write_savegame()

	# After creating or loading a save resource, we need to dispatch its data
	# to the various nodes that need it.
	_player.global_position = 
	#_ui_inventory.inventory = _save.inventory
	_player.stats = _save.character
	#_ui_info_display.character = _save.character


func _save_game() -> void:
	_save.global_position = _player.global_position
	_save.write_savegame()
