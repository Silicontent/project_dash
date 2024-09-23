class_name HealthComponent
extends Node

# sends when health depletes below 0
signal entity_killed

# max amount of health the entity has
@export var MAX_HEALTH := 1.0
# current amount of health the entity has
var health: float


func _ready() -> void:
	# set the initial health value
	health = MAX_HEALTH


func damage(amt: float) -> void:
	health -= amt
	
	if health <= 0:
		emit_signal("entity_killed")
