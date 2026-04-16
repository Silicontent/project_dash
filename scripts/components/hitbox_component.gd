class_name HitboxComponent
extends Area2D
## Adds a hitbox to an object that connects to the object's health
##
## A component that holds a collision hitbox for hit detection. It also
## connects to a health component to allow detected hits to reduce the
## object's health.

# reference to the entity's health component
@export var _health_component: HealthComponent


func damage(amt: float = 1.0) -> void:
	if _health_component:
		# tells the health component (if it exists) to reduce HP
		_health_component.damage(amt)
