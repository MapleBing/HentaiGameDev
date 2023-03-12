extends Node

var has_met_nathan = false
var has_met_maya = false
var has_item = false
var some_value = 0

func checkItem(itemID, quantity):
	var result
	result = SignalBus.emit_signal("Check_for_item",itemID, quantity)
	return result
func portraitNone():
	SignalBus.emit_signal("portrait_none")
	
func portraitLeft():
	SignalBus.emit_signal("portrait_left")
	
func portraitRight():	
	SignalBus.emit_signal("portrait_right")
