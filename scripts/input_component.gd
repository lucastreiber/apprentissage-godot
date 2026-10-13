class_name InputComponent extends Node

var direction : float = 0.0
var is_jumping : bool = false
var is_runing : bool = false
var is_attacking : bool = false

func update() -> void :
	direction = Input.get_axis("left","right")
	is_jumping = Input.is_action_pressed("jump")
	is_runing = Input.is_action_pressed("run")
	is_attacking = Input.is_action_just_pressed("attack")
