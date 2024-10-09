class_name Player
extends CharacterBody2D

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

# controls logic related to dashing
@onready var dash := $DashComponent

# flags if the player is unable to take damage
var vulnerable := true


func _ready() -> void:
	# set initial speed
	current_speed = BASE_SPEED


func _physics_process(delta: float) -> void:
	move()


# MOVING ================================================================================
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
