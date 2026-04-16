extends VBoxContainer

# reference to the player
@export var _player: Player
@onready var _charge_timer: Timer

# visually shows the time left on the dash charge
@onready var _dash_bar := $DashBar
# shows the time left on the dash charge as a number
@onready var _dash_bar_display := $DashBarDisplay


func _ready() -> void:
	_charge_timer = _player.dash_charge_timer


func _process(_delta: float) -> void:
	# set the bar value
	_dash_bar.value = snappedf((_charge_timer.time_left / _charge_timer.wait_time) * 100, 0.01)
	# set the bar display (formatting it to have two decimal places)
	# https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_format_string.html#padding
	_dash_bar_display.text = "%.2f" % _charge_timer.time_left


func _on_dash_bar_value_changed(value: float) -> void:
	# hides the number display if the charge is ready
	_dash_bar_display.visible = (value != 0)
