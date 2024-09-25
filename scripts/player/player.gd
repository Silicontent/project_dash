class_name Player
extends CharacterBody2D

# sent to the dash timer to tell it to restart
signal reset_dash_charge

#region speed & movement variables
# regular movement speed
const BASE_SPEED := 1000.0
# speed during a dash
const DASH_SPEED := 1500.0
# speed at the beginning of a dash
const MAX_SPEED := 2000.0

const ACCELERATION := 0.3
const FRICTION := 0.25

var current_speed: float
#endregion

# flags if the dash is charged
var dash_ready := false


func _ready() -> void:
	# set initial speed
	current_speed = BASE_SPEED


func _process(_delta: float) -> void:
	$Label.text = $StateMachine.state.name


# MOVING ======================================================================
func move() -> Vector2:
	# determine move direction
	var direction := Input.get_vector("mv_left", "mv_right", "mv_up", "mv_down")
	
	# apply acceleration
	velocity.x = lerp(velocity.x, direction.x * current_speed, ACCELERATION)
	velocity.y = lerp(velocity.y, direction.y * current_speed, ACCELERATION)
	
	# move the player
	move_and_slide()
	
	# used when checking if the player is no longer moving
	return direction


func stop() -> void:
	print(velocity)
	
	# apply friction
	velocity.x = lerp(velocity.x, 0.0, FRICTION)
	velocity.y = lerp(velocity.y, 0.0, FRICTION)
	
	move_and_slide()


# DASHING =====================================================================
func _on_dash_timer_timeout() -> void:
	dash_ready = true
