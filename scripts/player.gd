class_name Player extends CharacterBody2D

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent
@onready var animation_component: AnimationComponent = %AnimationComponent
@onready var attack_component: AttackComponent = %AttackComponent
var is_dead : bool = false
var is_attacking : bool = false
@export var knockback_strength_x : float = 800
@export var knockback_strength_y : float = 80


func _physics_process(delta: float) -> void:
	# On transfère à movement_commponent tous les mouvements en cours
	if !is_dead and !is_attacking:
		input_component.update()
		movement_component.direction = input_component.direction
		if input_component.direction < 0.0 :
			attack_component.scale.x = -1
		elif input_component.direction > 0.0 :
			attack_component.scale.x = 1
		animation_component.direction = input_component.direction
		animation_component.is_attacking = input_component.is_attacking
		animation_component.update()
		movement_component.is_jumping = input_component.is_jumping
		movement_component.is_runing = input_component.is_runing
		is_attacking = input_component.is_attacking
		if is_attacking:
			attack_component.attack() 
			await animation_component.end_attack
			is_attacking = false
			attack_component.is_attacking = false
	
	# On applique les mouvements
	if !is_attacking :
		movement_component.tick(delta)

func die(killer_name : String, knockback_dir : float) -> void:
	is_dead = true
	movement_component.direction = 0.0
	animation_component.direction = 0.0
	movement_component.is_jumping = false
	movement_component.is_runing = false
	animation_component.is_dead = true
	animation_component.is_attacking = false
	animation_component.update()
	
	# On applique la force de recul !
	# On multiplie la direction (1 ou -1) par la force souhaitée (ex: 300 pixels/sec)
	velocity.x = knockback_dir * knockback_strength_x
	
	# On ajoute un petit bond vers le haut (négatif sur Godot)
	velocity.y = -knockback_strength_y
	move_and_slide()
	
	print(killer_name)
