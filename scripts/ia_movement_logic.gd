class_name IAMovementLogic extends Area2D

var target : Player
var direction : float = 0.0
@onready var stop_to_move_3s: Timer = $StopToMove3s


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body


func _on_body_exited(body: Node2D) -> void: 
	if body is Player:
		target = null
		direction = 0.0


func _on_timer_timeout() -> void:
	if target == null :
		var choice : float = randf()
		if choice >= 0.5:
			direction = 1
		else :
			direction = -1
		stop_to_move_3s.start()
	

func _on_check_player_timeout() -> void:
	if target != null:
		direction = global_position.direction_to(target.global_position).x


func _on_stop_to_move_3s_timeout() -> void:
	if target == null :
		direction = 0.0
