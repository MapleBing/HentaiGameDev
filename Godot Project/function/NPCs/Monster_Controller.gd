 extends KinematicBody2D

#Movement Variables
export var ACCELERATION = 700
export var MAX_SPEED = 80
export var Step_Amount = 10
export var FRICTION = 200
export(int) var WANDER_RANGE_BOUNDS
export var Recovery_Time = 5
#internal Variables
var timer = 0
#Dialogue Variables
export(String, FILE) var dialogue_file
export var dialogue_key = ""

#Child Node Connections
onready var PlayerDetectionZone = $PlayerDetectionZone
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var WanderController = $WanderController

#Child Variable Connections
var player #from PlayerDetectionZone's script
var nearPlayer = false
var recovery = false
enum {
	IDLE,
	WANDER,
	FOLLOW,
	RECOVER
}

#var distance = global_position.distance_to (player.global_position)
var velocity = Vector2.ZERO
var state = IDLE

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	match state:
		IDLE:
			#Come to Stop
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			#Switch to Follow if player is close
			follow_player()
			wander_state()
				
		WANDER:
			follow_player()
			accelerate_towards(WanderController.target_position, delta)
			wander_state()
			
			if global_position.distance_to(WanderController.target_position) <= WANDER_RANGE_BOUNDS:
				state = pick_random_state([IDLE, WANDER])
		
		FOLLOW:
			#If player isnt close Set state Idle
			if player != null:
				accelerate_towards(player.global_position, delta)
			else:
				state = IDLE
				
		RECOVER:
			timer-= delta
			if timer<0:
				recovery = false
				state = IDLE
				follow_player()
			
				
	#Set Character sprite to the corrisponding movement values
	if velocity != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", velocity)
		animation_tree.set("parameters/walk/blend_position", velocity)
		animation_tree.set("parameters/stun/blend_position", velocity)
		animation_state.travel("walk")
		
	#Set Character sprite idle if the current value is zero
	else:
		if state == RECOVER:
			animation_state.travel("stun")
		else:
			animation_state.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		
	#Emit hScene signal if the player touches monster hitbox
	if nearPlayer and !state == RECOVER:
		SignalBus.emit_signal("display_enemy_hscene",dialogue_file, dialogue_key)
		recover_player()
		
	velocity = move_and_slide(velocity)
	
	#Toggle state from follow to idle
func follow_player():
	if player:
		print("follow")
		state = FOLLOW
		
func recover_player():
	nearPlayer = false
	state = RECOVER
	timer = Recovery_Time
	
func accelerate_towards(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

func wander_state():
	if WanderController.get_time_left() == 0:
			state = pick_random_state([IDLE, WANDER])
			WanderController.start_wander_timer(rand_range(1, 2))

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
	
