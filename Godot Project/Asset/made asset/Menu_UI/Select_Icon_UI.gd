extends Control
export(Array, Resource) var MenuEffects
var active = false
func _ready() -> void:
	TriggerMenuEffect()
	if get_position_in_parent() == 0:
		ShiftSelection(0)


func ShiftSelection(amount = 0):
	var parent = get_parent()
	var size = parent.get_child_count()-1

	print("")
	print("Current: ")
	print(self.name)
		
	var currentPosition = (get_position_in_parent() + amount) #cycles 0,1,2 for size of 3
	print(currentPosition)
	if currentPosition == -1:
		currentPosition = size
	elif currentPosition == (size + 1):
		currentPosition = 0
	print(currentPosition)
	if active == true:
		active = false
		parent.get_child(currentPosition).ShiftSelection(amount)
	else:
		active = true
	TriggerMenuEffect()

func TriggerMenuEffect():
	for effect in MenuEffects:
		if effect != null:
			effect.TriggerEffect(self)
			
func CheckActive() -> bool:
	return active
	
