extends KinematicBody2D

export var ACCELERATION = 700
export var MAX_SPEED = 80
export var FRICTION = 200
export var NPC_IS_STATIC = true

onready var PlayerDetectionZone = $PlayerDetectionZone
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

var player #from PlayerDetectionZone's script
var talking = false

enum {
	IDLE,
	WANDER,
	FOLLOW
}

#var distance = global_position.distance_to (player.global_position)
var velocity = Vector2.ZERO
var state = IDLE

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	match state:
		IDLE:
			#var player = PlayerDetectionZone.player
			#player = PlayerDetectionZone.player
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			if player != null and global_position.distance_to(player.global_position) >= 25:
				follow_player()
			
		WANDER:
			pass
		
		FOLLOW:
			#var player = PlayerDetectionZone.player
			#player = PlayerDetectionZone.player
			if player != null:
				var direction = global_position.direction_to(player.global_position)
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
				if global_position.distance_to(player.global_position) <= 20:
					state = IDLE
	
	if velocity != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", velocity)
		animation_tree.set("parameters/walk/blend_position", velocity)
		animation_state.travel("walk")
		#velocity = velocity.move_toward(velocity * MAX_SPEED, ACCELERATION * delta)
		
	else:
		animation_state.travel("idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	if talking:
		talking = false
	velocity = move_and_slide(velocity)
	
func follow_player():
	#if PlayerDetectionZone.player:
	if player and NPC_IS_STATIC:
	#if PlayerDetectionZone.see_player():
		print("follow")
		state = FOLLOW
	else:
		state = IDLE
func update_direction():
	var direction = global_position.direction_to(player.global_position)
	animation_tree.set("parameters/idle/blend_position", direction)
	animation_tree.advance(0)
	print_debug("working")
