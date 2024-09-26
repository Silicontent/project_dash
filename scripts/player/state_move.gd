extends PlayerState


func physics_update(_delta: float) -> void:
	var direction := player.move()
	
	# switch to idle if not moving
	if direction == Vector2.ZERO:
		emit_signal("finished", IDLE)
	
	# start the dash if the player can
	if Input.is_action_just_pressed("mv_dash") and player.dash_ready:
		player.dash_ready = false
		emit_signal("finished", DASH)
