extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	# set player speed to max speed for a very short amount of time
	player.current_speed = player.MAX_SPEED
	
	# slowly slow down to regular dash speed
	# start dash timer
	# switch to move state


func physics_update(_delta: float) -> void:
	var direction := player.move()
