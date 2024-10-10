extends Node

@onready var dash_timer := $DashTimer
# reference to the player for better autocompletion
@export var player: Player

# flags if the dash is charged
var dash_ready := false


func _physics_process(_delta: float) -> void:
	# start dashing if the player is able to
	if Input.is_action_just_pressed("mv_dash") and dash_ready:
		# prevent from dashing once started
		dash_ready = false
		
		dash()


func dash() -> void:
	# make the player invincible
	player.invulnerable = true
	
	# start the initial boost
	player.current_speed = player.MAX_SPEED
	
	# slow to the regular dashing speed
	var tween = get_tree().create_tween()
	tween.tween_property(player, "current_speed", player.DASH_SPEED, 0.5).set_ease(Tween.EASE_OUT)
	await tween.finished
	
	# start the dashing timer
	dash_timer.start()


# TIMERS ================================================================================
# runs when the current dash attack runs out
func _on_dash_timer_timeout() -> void:
	# restart the dash charge-up
	player.emit_signal("reset_dash_charge")
	
	# start iframe timer
	# slow to regular speed
	var tween = get_tree().create_tween()
	tween.tween_property(player, "current_speed", player.BASE_SPEED, 2.0).set_ease(Tween.EASE_OUT)
