extends Timer

# starting dash charge time
const INITIAL_TIME := 7.0
# the dash charge can't take longer than this
const MAX_TIME := 15.0
# how much the dash charge time increases by
const TIME_MULTIPLIER := 1.2

# reference to the player
@export var player: Player


func _ready() -> void:
	# connect to player's dash component to reset this timer
	player.dash.connect("reset", reset)
	
	# set initial time
	wait_time = INITIAL_TIME
	start()


func reset() -> void:
	# incrase the charge time
	wait_time *= TIME_MULTIPLIER
	wait_time = clamp(wait_time, INITIAL_TIME, MAX_TIME)

	start()
