class_name AnimationComponent extends Node

@export var sprite : AnimatedSprite2D
@export var body : CharacterBody2D
@export var SPEED : int = 100
@export var RUN_MULTIPLIER : float = 1.5

var is_dead : bool = false
var is_attacking : bool = false
var direction : float = 0.0
signal end_attack

func update() -> void :
	if body == null or sprite == null:
		print("body ou sprite non attribué")
		return
	
	# Animation
	if !is_dead and !is_attacking:
		if direction != 0.0 :
			sprite.flip_h = direction < 0.0
			
		if body.is_on_floor() :
			if body.velocity.x == 0.0:
				sprite.play("Idle")
			elif abs(body.velocity.x) <= SPEED :
				sprite.play("Walk")
			elif abs(body.velocity.x) <= SPEED * RUN_MULTIPLIER:
				sprite.play("Run")
		else :
			sprite.play("Jump")
	elif is_attacking :
		sprite.play("Attack1")
		await sprite.animation_finished
		end_attack.emit()
		sprite.play("Idle")
	else: 
		sprite.play("Hit")
		await sprite.animation_finished
		sprite.play("Death")
