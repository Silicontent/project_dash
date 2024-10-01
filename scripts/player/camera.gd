extends Camera2D

const REGULAR_ZOOM := 0.6
const MAX_ZOOM := 1.0
const DASH_ZOOM := 0.7


func _ready() -> void:
	# set initial zoom value
	zoom = Vector2.ONE * REGULAR_ZOOM
