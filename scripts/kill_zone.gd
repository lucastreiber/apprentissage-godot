class_name KillZone extends Area2D

signal player_killed
var player_dead : bool = false
var me_dead : bool = false

func _on_body_entered(body: Node2D) -> void:
	if !me_dead and !player_dead and body is Player:
		player_dead = true
		player_killed.emit()
		var knockback_direction : float = sign(body.global_position.x - global_position.x)
		var parent = get_parent()
		# On vérifie si le parent possède bien la variable avant de la lire
		if "enemy_name" in parent:
			body.die(parent.enemy_name, knockback_direction)
		else:
			body.die("un danger inconnu", knockback_direction)
		
