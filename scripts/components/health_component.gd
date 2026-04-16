class_name HealthComponent
extends Node

# sends when health depletes below 0
signal entity_killed

# max amount of health the entity has
@export var _MAX_HEALTH := 1.0
# current amount of health the entity has
var _health: float


func _ready() -> void:
	# set the initial health value
	_health = _MAX_HEALTH


func damage(amt: float) -> void:
	_health -= amt
	
	if _health <= 0:
		entity_killed.emit()


# GETTERS =====================================================================
func get_health() -> float:
	return _health


func get_max_health() -> float:
	return _MAX_HEALTH
