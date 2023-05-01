extends Control
export(Array, Resource) var MenuEffects
export var columbSize = 1
var active = false

func _ready() -> void:
	TriggerMenuEffect()
	if get_position_in_parent() == 0:
		ShiftSelection(0)


func ShiftSelection(amount = 0):
	var parent = get_parent()
	var size = parent.get_child_count()-1
	var currentPosition = (get_position_in_parent() + amount) #cycles 0,1,2 for size of 3


	if currentPosition < 0:
		currentPosition = size
	if currentPosition > size:
		currentPosition = 0

	if active == true:
		active = false
		parent.get_child(currentPosition).ShiftSelection(amount)
	else:
		active = true
	TriggerMenuEffect()
	
func ShiftRow(amount = 0):
	var parent = get_parent()
	var size = parent.get_child_count()
	amount = amount * columbSize
	ShiftSelection(amount)
	
func TriggerMenuEffect():
	for effect in MenuEffects:
		if effect != null:
			effect.TriggerEffect(self)

func CheckActive() -> bool:
	return active
