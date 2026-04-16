class_name Player
extends CharacterBody2D
## The main player class that process input into movement.
##
## This class contains all relevant player logic and data. It controls
## how input is interpreted, the current state of the player, and how
## to initiate and process dashing.

#region speed & movement variables
## The default, regular movement speed.
const BASE_SPEED := 1000.0
## The speed the player maintains during a dash.
const DASH_SPEED := 1750.0
## The initial boost of speed the player gets at the start of a dash.
const MAX_SPEED := 5000.0

## Used to smooth out movement.
const ACCELERATION := 0.3
## Used to smooth out movement.
const FRICTION := 0.25

## Value used during movement calculation to determine velocity.
var current_speed: float = BASE_SPEED
#endregion

#region dashing mechanic
## Controls logic related to dashing, including speed changes.
@onready var dash: DashComponent = $DashComponent
## Stores how much time is left before the player can dash again.
@onready var dash_charge_timer: Timer = $DashComponent/DashChargeTimer
#endregion

## Flags if the player is unable to take damage.
var invulnerable := false

# extra particles to improve the feel of movement
@onready var _move_particles: GPUParticles2D = $Appearance/MoveParticles


func _physics_process(_delta: float) -> void:
	_move()


# MOVING ================================================================================
func _move() -> void:
	# determine move direction
	var direction := Input.get_vector("mv_left", "mv_right", "mv_up", "mv_down")
	
	# apply acceleration or friction
	if direction != Vector2.ZERO:
		velocity.x = lerp(velocity.x, direction.x * current_speed, ACCELERATION)
		velocity.y = lerp(velocity.y, direction.y * current_speed, ACCELERATION)
		_move_particles.emitting = true
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)
		velocity.y = lerp(velocity.y, 0.0, FRICTION)
		_move_particles.emitting = false
	
	# move the player
	move_and_slide()
	
	# keep player inside of the game map
	position.x = clamp(position.x, -1920, 3840)
	position.y = clamp(position.y, -1080, 2160)
	# orient move particles in the correct direction
	_move_particles.rotation = atan2(direction.y, direction.x)


# DASHING ===============================================================================
func _on_dash_charge_timer_timeout() -> void:
	dash.dash_ready = true
