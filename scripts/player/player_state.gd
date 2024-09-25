class_name PlayerState
extends State

# names of all of the states the player can be in
const IDLE = "Idle"
const MOVE = "Move"
const DASH = "Dash"
const DEAD = "Dead"

# reference to the player for better auto-completion
var player: Player


func _ready() -> void:
	# set the player reference, throwing an error if the player state is used elsewhere
	await owner.ready
	player = owner as Player
	assert(player != null, "States extending from PlayerState can only be used in the player scene.")
