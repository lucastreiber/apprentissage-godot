extends Sprite2D

@export var dialogue_ressource: DialogueResource
const SCENE_BULLE = preload("res://scenes/balloon.tscn")

@onready var marker_2d: Marker2D = $Marker2D
var alredy_pass : bool = false

# Variables pour garder la caméra en mémoire
var camera_joueur: Camera2D
var position_origine_camera: Vector2

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !alredy_pass:
		alredy_pass = true
		
		# 3. ON MET LE JEU EN PAUSE (bloque les mouvements et les ennemis)
		get_tree().paused = true
		
		# 2. GESTION DE LA CAMÉRA : On récupère la caméra active (celle du joueur)
		camera_joueur = get_viewport().get_camera_2d()
		# On sauvegarde sa position locale d'origine (par rapport au joueur)
		position_origine_camera = camera_joueur.position 
		
		# 3. ANIMATION ALLER
		var tween = create_tween()
		tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS) # Indispensable : permet d'animer pendant la pause !
		# On déplace la caméra vers le sommet de la tour en 1 seconde de façon fluide
		tween.tween_property(camera_joueur, "global_position", marker_2d.global_position, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		
		# On attend que l'animation de la caméra soit finie avant d'afficher le texte
		await tween.finished
		
		# 4. On crée la bulle
		var bulle = SCENE_BULLE.instantiate()
		get_tree().current_scene.add_child(bulle)
		bulle.cible_suivie = marker_2d
		
		# 5. On lance le texte (remplace "start" si ton titre est différent)
		bulle.start(dialogue_ressource, "start")
		
		# 6. On écoute le signal de fin pour enlever la pause
		DialogueManager.dialogue_ended.connect(_on_dialogue_termine)
		

func _on_dialogue_termine(_resource: DialogueResource):
	DialogueManager.dialogue_ended.disconnect(_on_dialogue_termine)
	
	# 6. ANIMATION RETOUR
	var tween_retour = create_tween()
	tween_retour.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	# On ramène la caméra à sa position locale d'origine (le centre du joueur)
	tween_retour.tween_property(camera_joueur, "position", position_origine_camera, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	# On attend qu'elle soit de retour sur le joueur pour lui rendre les contrôles
	await tween_retour.finished
	get_tree().paused = false
