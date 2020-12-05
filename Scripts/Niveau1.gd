extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.count = 5


func _process(delta):
	if Global.count == 0:
			Global.goto_scene("res://Scenes/Niveau2.tscn")
