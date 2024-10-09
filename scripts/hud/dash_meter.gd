extends VBoxContainer

# reference to the dash timer
@export var dash_timer: Timer

# visually shows the time left on the dash charge
@onready var dash_bar := $DashBar
# shows the time left on the dash charge as a number
@onready var dash_bar_display := $DashBarDisplay


func _process(_delta: float) -> void:
	# set the bar value
	dash_bar.value = snappedf((dash_timer.time_left / dash_timer.wait_time) * 100, 0.01)
	# set the bar display (formatting it to have two decimal places)
	# https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_format_string.html#padding
	dash_bar_display.text = "%.2f" % dash_timer.time_left
