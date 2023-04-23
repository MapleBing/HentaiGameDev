extends Control
export(Array, Resource) var MenuEffects
var active = false
func _ready() -> void:
	TriggerMenuEffect()
	if get_position_in_parent() == 0:
		TriggerMenuEffect()
		print("Current:")
		print(self.name)
	
func ShiftSelection(amount = 0):
	active = false
	var parent = get_parent()
	var size = parent.get_parent().get_child_count()
	
	print("Current:")
	print(self.name)
	print(parent.name)
	print(get_position_in_parent())
	
	var currentPosition = (get_position_in_parent() + amount) % 3
	if currentPosition == -1:
		currentPosition += size
		
	
	parent.get_child(currentPosition).TriggerMenuEffect()
	
func TriggerMenuEffect():
	for effect in MenuEffects:
		print("Method:")
		print(effect.has_method("TriggerEffect"))
		if effect != null:
			effect.TriggerEffect(self)
			
func CheckActive() -> bool:
	return active
	
