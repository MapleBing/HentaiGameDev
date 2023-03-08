 extends KinematicBody2D

#Movement Variables
export var ACCELERATION = 700
export var MAX_SPEED = 80
export var Step_Amount = 10
export var FRICTION = 200

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
var state = FOLLOW

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	match state:
		IDLE:
			#Come to Stop
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			
			#Switch to Follow if player is close
			if player != null and global_position.distance_to(player.global_position) >= 25:
				follow_player()
				
		WANDER:
			pass
		
		FOLLOW:
			#If player isnt close Set state Idle
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				if global_position.distance_to(player.global_position) <= 20:
					follow_player()
		RECOVER:
			timer-= delta
			if timer<0:
				follow_player()
				recovery = false
	#Set Character sprite to the corrisponding movement values
	if velocity != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", velocity)
		animation_tree.set("parameters/walk/blend_position", velocity)
		animation_state.travel("walk")
		
	#Set Character sprite idle if the current value is zero
	else:
		animation_state.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
		
	#Emit hScene signal if the player touches monster hitbox
	if nearPlayer:
		SignalBus.emit_signal("display_enemy_hscene",dialogue_file, dialogue_key)
		recover_player()
		
	velocity = move_and_slide(velocity)
	
	#Toggle state from follow to idle
func follow_player():
	if player:
		state = FOLLOW
	else:
		state = IDLE
func recover_player():
	nearPlayer = false
	state = RECOVER
	timer = 10
	
