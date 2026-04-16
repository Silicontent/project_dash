class_name DashComponent
extends Node
## Component that contains all logic for dashing.
##
## This component was designed for use with the player. (which, now that I
## think about it, kinda defeats the point of it being a component...)
## All dashing logic, including changing player speed and starting timers,
## is placed in this script.

## Sent at the end of a dash to signal dash-related timers to reset.
signal reset

# references for easier connections and better autocompletion
@export var _player: Player
@export var _dash_particles: GPUParticles2D
@export var _anim_player: AnimationPlayer

# flags if the dash is charged
var _dash_ready := false

# the duration of a dash (where the player travels a bit faster than normal)
@onready var _dash_timer := $DashTimer
# how long the player remains invincible after a dash
@onready var _iframe_timer := $InvulnerableTimer
# plays a sound at the start of the dash
@onready var _dash_sfx := $DashSFX
# plays a sound when the dash is ready to activate
@onready var _dash_ready_sfx := $DashReadySFX


func _physics_process(_delta: float) -> void:
	var moving := Input.get_vector("mv_left", "mv_right", "mv_up", "mv_down") != Vector2.ZERO
	# start dashing if the player is able to
	# the dash timer must be 0, and the player must be moving
	if Input.is_action_just_pressed("mv_dash") and moving and _dash_ready:
		# prevent from dashing once started
		_dash_ready = false
		dash()


## Starts a dash by setting speeds, displaying particles, and starting the
## dash timer that determines how long the dash goes on for.
func dash() -> void:
	# make the player invincible
	_iframe_timer.stop()
	_anim_player.play("normal")
	_player.invulnerable = true
	
	# start the initial boost
	_player.current_speed = _player.MAX_SPEED
	# show visual effects
	_dash_sfx.play()
	_dash_particles.restart()
	
	# slow to the regular dashing speed
	var _tween = create_tween()
	_tween.tween_property(_player, "current_speed", _player.DASH_SPEED, 0.5).set_ease(Tween.EASE_IN_OUT)
	await _tween.finished
	
	# start the dashing timer
	_dash_timer.start()


# TIMERS ================================================================================
# runs when the current dash attack runs out
func _on_dash_timer_timeout() -> void:
	# restart the dash charge-up
	reset.emit()
	
	# start iframe timer
	_iframe_timer.start()
	_anim_player.play("invulnerable")
	
	# slow to regular speed
	var _tween = create_tween()
	_tween.tween_property(_player, "current_speed", _player.BASE_SPEED, 2.0).set_ease(Tween.EASE_OUT)


func _on_dash_charge_timeout() -> void:
	# allow the player to activate the dash
	_dash_ready = true
	_dash_ready_sfx.play()


func _on_invulnerable_timer_timeout() -> void:
	_player.invulnerable = false
	_anim_player.play("normal")
