class_name Player
extends CharacterBody2D

#region speed & movement variables
# regular movement speed
const BASE_SPEED := 1000.0
# main speed during a dash
const DASH_SPEED := 1750.0
# initial boost of speed at the beginning of a dash
const MAX_SPEED := 5000.0

const ACCELERATION := 0.3
const FRICTION := 0.25

var current_speed: float
#endregion

# controls logic related to dashing
@onready var dash := $DashComponent
# extra particles to improve the feel of movement
@onready var explosion: GPUParticles2D = $ExplosionParticles
@onready var move_particles: GPUParticles2D = $MoveParticles

# flags if the player is unable to take damage
var invulnerable := false


func _ready() -> void:
	# set initial speed
	current_speed = BASE_SPEED


func _physics_process(_delta: float) -> void:
	move()


# MOVING ================================================================================
func move() -> void:
	# determine move direction
	var direction := Input.get_vector("mv_left", "mv_right", "mv_up", "mv_down")
	
	# apply acceleration or friction
	if direction != Vector2.ZERO:
		velocity.x = lerp(velocity.x, direction.x * current_speed, ACCELERATION)
		velocity.y = lerp(velocity.y, direction.y * current_speed, ACCELERATION)
		move_particles.emitting = true
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)
		velocity.y = lerp(velocity.y, 0.0, FRICTION)
		move_particles.emitting = false
	
	# move the player
	move_and_slide()
	
	# keep player inside of the game map
	position.x = clamp(position.x, -1920, 3840)
	position.y = clamp(position.y, -1080, 2160)
	# orient move particles in the correct direction
	move_particles.rotation = atan2(direction.y, direction.x)


# DASHING ===============================================================================
func _on_dash_charge_timer_timeout() -> void:
	dash.dash_ready = true
