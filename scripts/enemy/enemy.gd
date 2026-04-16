class_name Enemy
extends CharacterBody2D

@export var player: Player

## Base speed the enemy travels at.
@export var speed: float = 0.0
## How many points the player receives upon killing the enemy.
@export var reward: int = 0

@onready var _death_particles := $DeathParticles


func _physics_process(_delta: float) -> void:
	velocity = (player.global_position - position).normalized() * speed
	move_and_slide()


# PLAYER COLLISION ============================================================
func _on_hitbox_entered(body: Node2D) -> void:
	body = body as Player
	# only act if the body is a player
	if body:
		if body.invulnerable:
			kill()
		else:
			get_tree().quit()


func kill() -> void:
	$Sprite.hide()
	# prevent collisions during death
	$Hitbox/CollisionShape2D.set_deferred("disabled", true)
	
	# increase score
	Globals.score += reward
	
	# show death animation
	$DeathSFX.play()
	_death_particles.restart()
	await _death_particles.finished
	
	queue_free()
