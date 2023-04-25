extends CanvasLayer


signal actioned(next_id)


onready var balloon := $Balloon
onready var margin := $Balloon/Margin
onready var character_label := $Balloon/Margin/VBox/Character/Text
onready var dialogue_label := $Balloon/Margin/VBox/Dialogue/Text
onready var dialogue := $Balloon/Margin/VBox/Dialogue
onready var responses_menu := $Balloon/Margin/VBox/Responses
onready var response_template := $Balloon/Margin/VBox/ResponsesTemplate


var dialogue_line: Dictionary
var is_waiting_for_input: bool = false


func _ready() -> void:
	if dialogue_line.size() == 0:
		queue_free()
		return
	
	response_template.hide()
	balloon.hide()
	dialogue.visible = false
	
	character_label.visible = dialogue_line.character != ""
	character_label.bbcode_text = dialogue_line.character
	
	dialogue_label.dialogue_line = dialogue_line
	yield(dialogue_label.reset_height(), "completed")
	
	# Show any responses we have
	if dialogue_line.responses.size() > 0:
		for response in dialogue_line.responses:
			# Duplicate the template so we can grab the fonts, sizing, etc
			var control_item: Control = response_template.duplicate(0)
			var text_item: RichTextLabel = control_item.get_child(0)
			text_item.name = "Response" + str(responses_menu.get_child_count())
			if not response.is_allowed:
				text_item.name += "Disallowed"
			text_item.bbcode_text = response.text
			text_item.connect("mouse_entered", self, "_on_response_mouse_entered", [text_item])
			text_item.connect("gui_input", self, "_on_response_gui_input", [text_item])
			control_item.show()
			responses_menu.add_child(control_item)
	# Make sure our responses get included in the height reset
	responses_menu.visible = true
	margin.rect_size = Vector2(0, 0)
	
	yield(get_tree(), "idle_frame")
	
	# Ok, we can hide it now. It will come back later if we have any responses
	responses_menu.visible = false
	
	# Show our box
	balloon.visible = true
	
	if dialogue_line.text != "":
		dialogue_label.type_out()
		dialogue.visible = true
		yield(dialogue_label, "finished")
		
	
	# Wait for input
	if dialogue_line.responses.size() > 0:
		responses_menu.visible = true
		configure_focus()
	elif dialogue_line.time != null:
		var time = dialogue_line.text.length() * 0.02 if dialogue_line.time == "auto" else dialogue_line.time.to_float()
		yield(get_tree().create_timer(time), "timeout")
		next(dialogue_line.next_id)
	else:
		is_waiting_for_input = true
		balloon.focus_mode = Control.FOCUS_ALL
		balloon.grab_focus()

func next(next_id: String) -> void:
	emit_signal("actioned", next_id)
	queue_free()


### Helpers


func configure_focus() -> void:
	responses_menu.show()
	
	var responseArray = get_responses()
	for i in responseArray.size():
		var response: Control = responseArray[i]
		
		response.focus_mode = Control.FOCUS_ALL
		
		response.focus_neighbour_left = response.get_path()
		response.focus_neighbour_right = response.get_path()
		
		if i == 0:
			response.focus_neighbour_top = response.get_path()
			response.focus_previous = response.get_path()
		else:
			response.focus_neighbour_top = responseArray[i - 1].get_path()
			response.focus_previous = responseArray[i - 1].get_path()
		
		if i == responseArray.size() - 1:
			response.focus_neighbour_bottom = response.get_path()
			response.focus_next = response.get_path()
		else:
			response.focus_neighbour_bottom = responseArray[i + 1].get_path()
			response.focus_next = responseArray[i + 1].get_path()
	
	responseArray[0].grab_focus()


func get_responses() -> Array:
	var responseArray: Array = []
	for child in responses_menu.get_children():
		if "disallowed" in child.name.to_lower(): continue
		responseArray.append(child.get_child(0))
	return responseArray


### Signals


func _on_response_mouse_entered(response) -> void:
	if not "disallowed" in response.name.to_lower():
		response.grab_focus()


func _on_response_gui_input(event, response) -> void:
	if "disallowed" in response.name.to_lower(): return
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		next(dialogue_line.responses[response.get_parent().get_index()].next_id)
	elif event.is_action_pressed("Interact") and response in get_responses():
		next(dialogue_line.responses[response.get_parent().get_index()].next_id)


# When there are no response options the balloon itself is the clickable thing
func _on_Balloon_gui_input(event) -> void:
	if not is_waiting_for_input: return
	
	get_tree().set_input_as_handled()
	
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		next(dialogue_line.next_id)
	elif event.is_action_pressed("Interact") and balloon.get_focus_owner() == balloon:
		next(dialogue_line.next_id)
