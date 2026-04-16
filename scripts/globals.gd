extends Node

var _quit_pressed := false


func _input(event: InputEvent) -> void:
	# DEBUG: quit game after pressing pause twice
	if event.is_action_pressed("pause"):
		if _quit_pressed:
			get_tree().quit()
		else:
			_quit_pressed = true
			%QuitTimer.start()


func _on_quit_timer_timeout() -> void:
	_quit_pressed = false
