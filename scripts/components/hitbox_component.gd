class_name HitboxComponent
extends Area2D

# reference to the entity's health component
@export var health_component: HealthComponent


func damage(amt: float) -> void:
	if health_component:
		# tells the health component (if it exists) to reduce HP
		health_component.damage(amt)
