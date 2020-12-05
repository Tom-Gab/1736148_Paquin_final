extends TextureRect

func _on_restart_pressed():
	Global.goto_scene("res://Scenes/Niveau1.tscn")
# Called when the node enters the scene tree for the first time.

func _on_quit_pressed():
	get_tree().quit()

func _process(delta):
	pass
