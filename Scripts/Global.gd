extends Node

var current_scene = null
var count = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count()-1)

func goto_scene(path):
	call_deferred("_defered_goto_scene", path)
	
func _defered_goto_scene(path):
	#detruit la scene actuelle
	current_scene.free()
	var new_scene = ResourceLoader.load(path)
	#instancier la scene
	current_scene = new_scene.instance()
	#ajouter l'instance du niveau dans l'arbre
	get_tree().get_root().add_child(current_scene)
	#assurer la compatibilite avec l'API de changement
	get_tree().set_current_scene(current_scene)
