extends PlayerState


func physics_update(_delta: float) -> void:
	var direction := player.move()
	
	if direction == Vector2.ZERO:
		emit_signal("finished", IDLE)
