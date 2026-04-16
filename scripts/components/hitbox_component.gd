class_name HitboxComponent
extends Area2D

# reference to the entity's health component
@export var _health_component: HealthComponent


func damage(amt: float = 1.0) -> void:
	if _health_component:
		# tells the health component (if it exists) to reduce HP
		_health_component.damage(amt)
