class_name MovementComponent extends Node

@export var body : CharacterBody2D
@export var SPEED : int = 100
@export var RUN_MULTIPLIER : float = 1.5
@export var GRAVITY : int = 1
@export var JUMP_VELOCITY : int = 300

var direction : float = 0.0
var is_jumping : bool = false
var is_runing : bool = false

func tick(delta : float) -> void :
	# On sort du code si on a pas le body attribué 
	if body == null:
		print("body non attribué")
		return
	
	# Applique les mouvemnets horizontaux
	if is_runing:
		body.velocity.x = direction * SPEED * RUN_MULTIPLIER
	else :
		body.velocity.x = direction * SPEED
	
	# Applique la gravité
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * GRAVITY * delta
	
	# Jump
	if body.is_on_floor() and is_jumping:
		body.velocity.y = -JUMP_VELOCITY
	
	
	body.move_and_slide()
	
	
	
