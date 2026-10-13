class_name Meckano extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

signal tourVersAvion_finish 

func demiTour() -> void :
	sprite.flip_h = !sprite.flip_h
	sprite.play("Rotate")
	await sprite.animation_finished
	
func jump() -> void :
	sprite.play("Jump")

func walk() -> void :
	sprite.play("Walk")

func idle() -> void :
	sprite.play("Idle")

func tourVersAvion() -> void :
	var tween : Tween = create_tween()
	demiTour()
	walk()
	# Ligne droite
	tween.tween_property(self, "global_position:x", 140, 4.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).as_relative()
	await tween.finished
	for i in range(6):
		# Saut (x,y)
		# x
		var tween_x : Tween = create_tween()
		tween_x.tween_property(self, "global_position:x", 30, 1.0).as_relative()
		# 2. Le Tween pour sauter (Axe Y)
		var tween_y = create_tween()
		# Il monte jusqu'au sommet (la moitié du temps)
		tween_y.tween_property(self, "global_position:y", -25, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT).as_relative()
		# Puis il redescend jusqu'à la cible (l'autre moitié du temps)
		tween_y.tween_property(self, "global_position:y", 9, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN).as_relative()
		# animation de saut
		jump()
		# on att que le tween à fini 
		await tween_x.finished
	walk()
	# Ligne droite v2
	tween = create_tween()
	tween.tween_property(self, "global_position:x", 280, 4.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).as_relative()
	await tween.finished
	demiTour()
	tourVersAvion_finish.emit()
