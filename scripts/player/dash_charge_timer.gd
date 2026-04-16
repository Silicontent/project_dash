extends Timer

# starting dash charge time
const _INITIAL_TIME := 7.0
# the dash charge can't take longer than this
const _MAX_TIME := 15.0
# how much the dash charge time increases by
const _TIME_MULTIPLIER := 1.2


func _ready() -> void:
	# set initial time
	wait_time = _INITIAL_TIME
	start()


func _reset() -> void:
	# incrase the charge time
	wait_time *= _TIME_MULTIPLIER
	wait_time = clamp(wait_time, _INITIAL_TIME, _MAX_TIME)

	start()
