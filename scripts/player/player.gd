class_name Player
extends CharacterBody2D

# sent to the dash timer to tell it to restart
signal reset_dash_charge

#region speed & movement variables
# regular movement speed
const BASE_SPEED := 1000.0
# speed during a dash
const DASH_SPEED := 2500.0
# speed at the beginning of a dash
const MAX_SPEED := 4000.0

const ACCELERATION := 0.3
const FRICTION := 0.25

var current_speed: float
#endregion

# amount of time the dash lasts for
@onready var dash_timer := $DashTimer

# flags if the dash is charged
var dash_ready := false
# flags if the player is currently dashing
var dashing := false
# flags if the player is unable to take damage
var vulnerable := true


func _ready() -> void:
	# set initial speed
	current_speed = BASE_SPEED


func _physics_process(delta: float) -> void:
	move()
	
	# start dashing if the player is able to
	if Input.is_action_just_pressed("mv_dash") and dash_ready:
		pass


# MOVING ======================================================================
func move() -> void:
	# determine move direction
	var direction := Input.get_vector("mv_left", "mv_right", "mv_up", "mv_down")
	
	# apply acceleration or friction
	if direction != Vector2.ZERO:
		velocity.x = lerp(velocity.x, direction.x * current_speed, ACCELERATION)
		velocity.y = lerp(velocity.y, direction.y * current_speed, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)
		velocity.y = lerp(velocity.y, 0.0, FRICTION)
	
	# move the player
	move_and_slide()


# DASHING =====================================================================
func _on_dash_charge_timer_timeout() -> void:
	dash_ready = true
