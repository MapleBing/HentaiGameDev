extends Control
export(Array, Resource) var MenuEffect
var active = false
func _ready() -> void:
	TriggerMenuEffect()
	if get_position_in_parent() == 0:
		TriggerMenuEffect()
func ShiftSelection(amount = 0):
	active = false
	var parent = get_parent()
	var size = parent.get_parent().get_child_count()
	
	print("Current")
	print(get_position_in_parent())
	
	var currentPosition = (get_position_in_parent() + amount) % 3
	if currentPosition == -1:
		currentPosition += size
		
	
	parent.get_child(currentPosition).TriggerMenuEffect()
	
func TriggerMenuEffect():
	active = true
	for effect in MenuEffect:
		if effect != null and effect.has_method("TriggerEffect"):
			effect.TriggerEffect(get_child(0))
func CheckActive() -> bool:
	return active
