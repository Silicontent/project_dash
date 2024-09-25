class_name State
extends Node

# sends when the state is finished and wants to transition to another state
signal finished(next_state_path: String, data: Dictionary)


# VIRTUAL FUNCTIONS ===========================================================
func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


# TRANSITIONING ===============================================================
func enter(previous_state_path: String, data := {}) -> void:
	pass


func exit() -> void:
	pass
