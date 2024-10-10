extends Timer

# starting dash charge time
const INITIAL_TIME := 7.0
# the dash charge can't take longer than this
const MAX_TIME := 20.0
# how much the dash charge time increases by
var TIME_MULTIPLIER := 1.25


func _ready() -> void:
	# set initial time
	wait_time = INITIAL_TIME
	start()


func reset() -> void:
	# incrase the charge time
	wait_time *= TIME_MULTIPLIER
	wait_time = clamp(wait_time, INITIAL_TIME, MAX_TIME)

	start()
