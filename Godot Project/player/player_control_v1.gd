extends KinematicBody2D

onready var sta = 300
export(float) var ACCELERATION = 700
export(float) var MAX_SPEED = 80
export(float) var FRICTION = 430

var velocity = Vector2.ZERO
var punish = false
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

enum state {idle, walk} #從0開始，給int

var stats: Character setget set_stats

func set_stats(new_stats: Character) -> void:
	stats = new_stats
	set_physics_process(stats != null)

func _process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", input_vector)
		animation_tree.set("parameters/walk/blend_position", input_vector)
		animation_tree.set("parameters/Transition/current", state.walk) #於enum，給int
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	

	else:
		animation_tree.set("parameters/Transition/current", state.idle) #於enum，給int
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	if Input.is_action_pressed("run") and punish == false: #若 shift按下 = true 且 非力竭
		if input_vector != Vector2.ZERO: #若 靜止狀態 = false
			animation_tree.set("parameters/animation_speed/scale",2) #動畫速度 * 2
			sta = sta - 1; #每單位時間 體力 - 1
			MAX_SPEED = 160 #移動速度 * 2 
				

	if not Input.is_action_pressed("run") and sta < 300: #若 按下shift = false 且 體力未滿
		animation_tree.set("parameters/animation_speed/scale",1) 
		sta += 1
		MAX_SPEED = 80 
	
	if sta == 0: #若體力低於0，力竭=true。
		punish = true
		
	if punish == true: #力竭=true，玩家移動速度*0.5
		animation_tree.set("parameters/animation_speed/scale",0.5) 
		MAX_SPEED = 40 
		if sta > 299: #體力恢復後，力竭=false
			punish = false 
			animation_tree.set("parameters/animation_speed/scale",1) 
			MAX_SPEED = 80 

	#於debugger介面輸出體力,力竭，動畫播放速度的參數
	velocity = move_and_slide(velocity)
