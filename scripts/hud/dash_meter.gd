extends Control

# reference to the dash timer
@export var dash_timer: Timer

# visually shows the time left on the dash charge
@onready var dash_bar := $DashBar


func _process(_delta: float) -> void:
	dash_bar.value = snappedf((dash_timer.time_left / dash_timer.wait_time) * 100, 0.01)
	
