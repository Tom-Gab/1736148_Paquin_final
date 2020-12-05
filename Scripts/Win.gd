extends TextureRect

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	pass

func _on_replay_pressed():
	Global.goto_scene("res://Scenes/Niveau1.tscn")
