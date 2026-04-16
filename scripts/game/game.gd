extends Node2D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	# DEBUG: show current version
	%DebugInfo.text = "Project: Dash v%s\n%s" % [ProjectSettings.get_setting("application/config/version"), %DebugInfo.text]


func _process(_delta: float) -> void:
	# DEBUG: show FPS counter
	%DebugFPS.text = "%d FPS" % [roundf(Engine.get_frames_per_second())]
