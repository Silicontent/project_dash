extends PlayerState


func physics_update(_delta: float) -> void:
	player.stop()
	
	var direction := Input.get_vector("mv_left", "mv_right", "mv_up", "mv_down")
	if direction != Vector2.ZERO:
		emit_signal("finished", MOVE)
