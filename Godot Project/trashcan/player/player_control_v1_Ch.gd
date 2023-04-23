extends KinematicBody2D

onready var maxSta = 5000
onready var sta = 0
export(float) var ACCELERATION = 3000
export(float) var MAX_SPEED = 200
export(float) var FRICTION = 3500
var CurrentMax_Speed = MAX_SPEED

var velocity = Vector2.ZERO
var punish = false
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

enum state {idle, walk} #從0開始，給int
enum Direction {Up,Dn,Left,Right}
var currentDirection = Direction.Up
var stats: Character setget set_stats

func set_stats(new_stats: Character) -> void:
	stats = new_stats
	set_physics_process(stats != null)
	
func _start():
	sta = maxSta
	
func _process(delta):
	var input_vector = Vector2.ZERO
	var inputDif = 0
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	inputDif += abs(velocity.x - input_vector.x)
	inputDif += abs(velocity.y - input_vector.y)
	input_vector = input_vector.normalized()
	if input_vector != Vector2.ZERO and inputDif > .8:
		print(inputDif)
		animation_tree.set("parameters/idle/blend_position", input_vector)
		animation_tree.set("parameters/walk/blend_position", input_vector)
		animation_tree.set("parameters/Transition/current", state.walk) #於enum，給int
		velocity = velocity.move_toward(input_vector * CurrentMax_Speed, ACCELERATION * delta)
	else:
		animation_tree.set("parameters/Transition/current", state.idle) #於enum，給int
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	if Input.is_action_pressed("run") and punish == false: #若 shift按下 = true 且 非力竭
		if input_vector != Vector2.ZERO: #若 靜止狀態 = false
			animation_tree.set("parameters/animation_speed/scale",2) #動畫速度 * 2
			sta = sta - 1; #每單位時間 體力 - 1
			CurrentMax_Speed = MAX_SPEED * 1.5 #移動速度 * 2 
				

	elif sta < maxSta: #若 按下shift = false 且 體力未滿
		animation_tree.set("parameters/animation_speed/scale",1) 
		sta += 1
		CurrentMax_Speed = MAX_SPEED 
	
	if sta == 0: #若體力低於0，力竭=true。
		punish = true
		
	if punish == true: #力竭=true，玩家移動速度*0.5
		animation_tree.set("parameters/animation_speed/scale",0.5) 
		CurrentMax_Speed = MAX_SPEED/1.5 
		if sta > sta - 1: #體力恢復後，力竭=false
			punish = false 
			animation_tree.set("parameters/animation_speed/scale",1) 
			CurrentMax_Speed = MAX_SPEED

	#於debugger介面輸出體力,力竭，動畫播放速度的參數
	velocity = move_and_slide(velocity)
func getStrongestButton():
	var highestStrength = 0
	if Input.get_action_strength("ui_right"):
		currentDirection = currentDirection.Right
	if Input.get_action_strength("ui_left"):
		currentDirection = currentDirection.Left
	if Input.get_action_strength("ui_down"):
		currentDirection = currentDirection.Dn
	if Input.get_action_strength("ui_up"):
		currentDirection = currentDirection.Up
