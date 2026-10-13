extends Node2D

# Les Slimes 
var slimes = [false, false, false]

@onready var meckano: Meckano = $Meckano
@onready var marker_2d: Marker2D = $Meckano/Marker2D
@export var dialogue_ressource: DialogueResource
@export var dialogue_panne: DialogueResource
const SCENE_BULLE = preload("res://scenes/balloon.tscn")


func has_kill_every_slime() -> void :
	if slimes[0] and slimes[1] and slimes[2] :
		meckano.visible = true
		var bulle = SCENE_BULLE.instantiate()
		get_tree().current_scene.add_child(bulle)
		bulle.cible_suivie = marker_2d
		# 5. On lance le texte (remplace "start" si ton titre est différent)
		bulle.start(dialogue_ressource, "start")
		#On att qu'il finisse de parler
		await DialogueManager.dialogue_ended
		# il marche vers l'avion
		meckano.tourVersAvion()
		await meckano.tourVersAvion_finish
		# et là il reparle
		bulle = SCENE_BULLE.instantiate()
		get_tree().current_scene.add_child(bulle)
		bulle.cible_suivie = marker_2d
		bulle.start(dialogue_panne, "start")
	
func _on_slime_2_is_dying() -> void:
	slimes[0] = true
	has_kill_every_slime()


func _on_slime_3_is_dying() -> void:
	slimes[1] = true
	has_kill_every_slime()


func _on_slime_4_is_dying() -> void:
	slimes[2] = true
	has_kill_every_slime()
