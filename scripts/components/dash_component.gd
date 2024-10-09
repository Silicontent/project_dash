extends Node

# sent to the dash timer to tell it to restart
signal reset_dash_charge

# flags if the dash is charged
var dash_ready := false


func _physics_process(delta: float) -> void:
	# start dashing if the player is able to
	if Input.is_action_just_pressed("mv_dash") and dash_ready:
		# prevent from dashing once started
		dash_ready = false
		
		dash()


func dash() -> void:
	pass
	
	# make the player invincible
	# start the initial boost
	# slow to the regular dashing speed
	# start the dashing timer


# TIMERS ================================================================================
# runs when the dash is fully charged up
func _on_dash_charge_timer_timeout() -> void:
	dash_ready = true


# runs when the current dash attack runs out
func _on_dash_timer_timeout() -> void:
	pass
	
	# restart the dash charge-up
	# start iframe timer
	# slow to regular speed
