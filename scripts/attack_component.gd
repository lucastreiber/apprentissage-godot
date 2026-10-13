class_name AttackComponent extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var cible : Node2D = null
var is_attacking : bool = false

func attack() -> void :
	is_attacking = true
	
	
func _on_body_entered(body: Node2D) -> void:
	if is_attacking:
		var knockback_direction : float = sign(body.global_position.x - global_position.x)
		body.die(knockback_direction)
