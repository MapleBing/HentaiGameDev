extends KinematicBody2D

export var ACCELERATION = 700
export var MAX_SPEED = 80
export var FRICTION = 200
export(int) var WANDER_RANGE_BOUNDS

onready var PlayerDetectionZone = $PlayerDetectionZone
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")
onready var WanderController = $WanderController

var player #from PlayerDetectionZone's script

enum {
	IDLE,
	WANDER,
	FOLLOW
}

#var distance = global_position.distance_to (player.global_position)
var velocity = Vector2.ZERO
var state = FOLLOW

func _ready():
	state = pick_random_state([IDLE, WANDER])

func _physics_process(delta):
	#velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	match state:
		IDLE:
			#var player = PlayerDetectionZone.player
			#player = PlayerDetectionZone.player
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			follow_player()
			wander_state()
			
		WANDER:
			follow_player()
			accelerate_towards(WanderController.target_position, delta)
			wander_state()
			
			if global_position.distance_to(WanderController.target_position) <= WANDER_RANGE_BOUNDS:
				state = pick_random_state([IDLE, WANDER])
			
		FOLLOW:
			#var player = PlayerDetectionZone.player
			#player = PlayerDetectionZone.player
			if player != null:
				accelerate_towards(player.global_position, delta)
			else:
				state = IDLE
	
	if velocity != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", velocity)
		animation_tree.set("parameters/walk/blend_position", velocity)
		animation_state.travel("walk")
		#velocity = velocity.move_toward(velocity * MAX_SPEED, ACCELERATION * delta)
		
	else:
		animation_state.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	velocity = move_and_slide(velocity)

func accelerate_towards(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)

func wander_state():
	if WanderController.get_time_left() == 0:
			state = pick_random_state([IDLE, WANDER])
			WanderController.start_wander_timer(rand_range(1, 2))

func follow_player():
	if player:
		print("follow")
		state = FOLLOW

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()
