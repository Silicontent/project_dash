extends Node

# sent to the player to reset the dash charge
signal reset

@onready var dash_timer := $DashTimer
@onready var dash_sfx := $DashSFX
# reference to the player for better autocompletion
@export var player: Player

# flags if the dash is charged
var dash_ready := false


func _physics_process(_delta: float) -> void:
	var moving := Input.get_vector("mv_left", "mv_right", "mv_up", "mv_down") != Vector2.ZERO
	# start dashing if the player is able to
	# the dash timer must be 0, and the player must be moving
	if Input.is_action_just_pressed("mv_dash") and moving and dash_ready:
		# prevent from dashing once started
		dash_ready = false
		dash()


func dash() -> void:
	# make the player invincible
	player.invulnerable = true
	
	# start the initial boost
	player.current_speed = player.MAX_SPEED
	dash_sfx.play()
	player.explosion.restart()
	
	# slow to the regular dashing speed
	var tween = create_tween()
	tween.tween_property(player, "current_speed", player.DASH_SPEED, 0.5).set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	
	# start the dashing timer
	dash_timer.start()


# TIMERS ================================================================================
# runs when the current dash attack runs out
func _on_dash_timer_timeout() -> void:
	# restart the dash charge-up
	reset.emit()
	
	# TODO: start iframe timer
	# slow to regular speed
	var tween = create_tween()
	tween.tween_property(player, "current_speed", player.BASE_SPEED, 2.0).set_ease(Tween.EASE_OUT)
