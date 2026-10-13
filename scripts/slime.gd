class_name Slime extends CharacterBody2D

@onready var movement_component: MovementComponent = %MovementComponent
@onready var ia_movement_logic: IAMovementLogic = %IAMovementLogic
@onready var animation_component: AnimationComponent = %AnimationComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var kill_zone: KillZone = %KillZone
@export var knockback_strength_x : float = 800
@export var knockback_strength_y : float = 80
var enemy_name : String = "Slime"
var player_dead : bool = false
var is_dead : bool = false

signal is_dying

func _physics_process(delta: float) -> void:
	if !player_dead and !is_dead:
		movement_component.direction = ia_movement_logic.direction
		animation_component.direction = ia_movement_logic.direction
		animation_component.update()
		
	movement_component.tick(delta)
	


func _on_kill_zone_player_killed() -> void:
	if !is_dead and !player_dead :
		player_dead = true
		movement_component.direction = 0.0
		animation_component.direction = 0.0
		animated_sprite_2d.play("Attack")
		await animated_sprite_2d.animation_finished
		animated_sprite_2d.play("Idle")
	

func die(knockback_dir : float) -> void :
	if !is_dead :
		is_dying.emit()
		is_dead = true
		kill_zone.me_dead = true
		movement_component.direction = 0.0
		animation_component.direction = 0.0
		animation_component.is_dead = true
		animation_component.update()
		# On applique la force de recul !
		# On multiplie la direction (1 ou -1) par la force souhaitée (ex: 300 pixels/sec)
		velocity.x = knockback_dir * knockback_strength_x
		
		# On ajoute un petit bond vers le haut (négatif sur Godot)
		velocity.y = -knockback_strength_y
		move_and_slide()
	
	
	
