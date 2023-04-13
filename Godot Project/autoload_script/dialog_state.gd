extends Node
var has_met_nathan = false
var has_met_maya = false
var has_item = false
var some_value = 0
var result = false

func _ready():
	SignalBus.connect("get_item_result", self, "getItemResult")
	
func checkItem(itemID, quantity):
	SignalBus.emit_signal("check_for_item",itemID, quantity)
	return result

func getItemResult(Result = false):
	result = Result

func portraitNone():
	SignalBus.emit_signal("portrait_none")

func portraitLeft():
	SignalBus.emit_signal("portrait_left")

func portraitRight():	
	SignalBus.emit_signal("portrait_right")

func startHScene(hSceneName = ""):
	SignalBus.emit_signal("portrait_none")
	SignalBus.emit_signal("start_h_scene",hSceneName)

func endHScene():	
	SignalBus.emit_signal("portrait_none")
	SignalBus.emit_signal("end_h_scene")

func changeAnim(animationName = ""):
	SignalBus.emit_signal("change_anim",animationName)
