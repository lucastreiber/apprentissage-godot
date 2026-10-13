extends Control




func _on_btn_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_btn_option_pressed() -> void:
	pass # Replace with function body.


func _on_btn_quitte_pressed() -> void:
	get_tree().quit()
