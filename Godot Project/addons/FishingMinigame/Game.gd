extends Node2D
export var hookVelocity = 0;
export var hookAcceleration = 1.4;
export var hookDeceleration = .4
export var maxVelocity = 5.5;
export var bounce = .7

var hookArea = false
var fishable = true;
onready var fish = load("res://addons/FishingMinigame/Fish.tscn")


func _physics_process(delta: float) -> void:
	if ($Clicker.pressed == true):
		if hookVelocity > -maxVelocity:
			hookVelocity -= hookAcceleration
	else:
		if hookVelocity < maxVelocity:
			hookVelocity += hookDeceleration
			
	if (Input.is_action_just_pressed("ui_accept")):
		hookVelocity -= .5
		
	var target = $Hook.position.y + hookVelocity
	if (target >= 280):
		hookVelocity *= -bounce
	elif (target <= 38):
		hookVelocity = 0
		$Hook.position.y = 38
	else:
		$Hook.position.y = target
		
	# Adjust Value
	if (fishable == false):
		SignalBus.emit_signal("change_anim", "HScene")
		if (hookArea):
			$Progress.value += 125 * delta
			if ($Progress.value >= 999):
				caught_fish()
				
		else:
			$Progress.value -= 100 * delta
			if ($Progress.value <= 0):
				lost_fish()
				
	elif (fishable == true and $Progress.value > 0):
		$Progress.value -= 200 * delta
		SignalBus.emit_signal("change_anim", "HSceneEnd")
	update_speed()
	
		
func update_speed():
	if$Progress.value > 850:
		SignalBus.emit_signal("playspeed_anim",($Progress.value / 10.0))
	elif$Progress.value > 750:
		SignalBus.emit_signal("playspeed_anim",($Progress.value / 250.0))
	elif$Progress.value > 500:
		SignalBus.emit_signal("playspeed_anim",($Progress.value / 400.0))
	else:
		SignalBus.emit_signal("playspeed_anim",($Progress.value / 400.0))
		
	
	
func caught_fish():
	get_node("Fish").destroy()
	$Message.text = "Caught one!"
	$MessageTimer.set_wait_time(3);
	$MessageTimer.start()
	fishable = true
	
func lost_fish():
	get_node("Fish").destroy()
	$Message.text = "Next time!"
	$MessageTimer.set_wait_time(3);
	$MessageTimer.start()
	$Progress.value = 0
	fishable = true
	
func add_fish(min_d, max_d, move_speed, move_time):
	var f = fish.instance()
	f.position = Vector2($Hook.position.x, $Hook.position.y)
	
	f.min_distance = min_d
	f.max_distance = max_d
	f.movement_speed = move_speed
	f.movement_time = move_time
	
	add_child(f)
	$Progress.value = 200
	fishable = false

func _on_IncreaseSpeed_pressed():
	maxVelocity += .5

func spawn_easy():
	if (fishable):
		add_fish(10, 40, 8, 3)
		fishable = false


func spawn_medium():
	if (fishable):
		add_fish(30, 80, 4, 2)
		fishable = false


func spawn_hard():
	if (fishable):
		add_fish(40, 100, 4, 1.5)
		fishable = false


func spawn_impossible():
	if (fishable):
		add_fish(60, 140, 3, 1)
		fishable = false


func spawn_seriously():
	if (fishable):
		add_fish(85, 160, 2, 1)
		fishable = false



func _on_MessageTimer_timeout():
	$Message.text = ""


func _on_Clicker_button_down():
	hookVelocity -= .5
	SignalBus.emit_signal("restart_anim", true)


func _on_Area2D_area_entered(area: Area2D):
	hookArea = true
	pass # Replace with function body.


func _on_Area2D_area_exited(area: Area2D):
	hookArea = false
	pass # Replace with function body.


func _on_EndGame_button_down():
	SignalBus.emit_signal("setUpEndGame")
	pass # Replace with function body.

