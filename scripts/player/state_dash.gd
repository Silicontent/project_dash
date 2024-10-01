extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	# set player speed to max speed for a very short amount of time
	player.current_speed = player.MAX_SPEED
	
	var tween = get_tree().create_tween()
	tween.tween_property(player, "current_speed", player.DASH_SPEED, 0.25).set_trans(Tween.TRANS_QUAD)
	await tween.finished
	
	# start dash timer
	# switch to move state


func physics_update(_delta: float) -> void:
	var direction := player.move()
