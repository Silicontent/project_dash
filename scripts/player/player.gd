class_name Player
extends CharacterBody2D

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

# counts down to when the player can dash
@onready var dash_timer := $DashTimer

# flags if the dash is charged
var dash_ready := false


func _ready() -> void:
	# set initial speed
	current_speed = BASE_SPEED


func _physics_process(delta: float) -> void:
	move()
	
	# determine dash
	if Input.is_action_just_pressed("mv_dash") and dash_ready:
		dash_ready = false
		dash_timer.reset()


func move() -> void:
	# determine move direction
	var direction := Input.get_vector("mv_left", "mv_right", "mv_up", "mv_down")
	
	# apply acceleration/friction
	if direction != Vector2.ZERO:
		velocity.x = lerp(velocity.x, direction.x * current_speed, ACCELERATION)
		velocity.y = lerp(velocity.y, direction.y * current_speed, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION)
		velocity.y = lerp(velocity.y, 0.0, FRICTION)
	
	# move the player
	move_and_slide()
