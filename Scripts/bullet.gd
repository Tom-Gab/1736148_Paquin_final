extends KinematicBody2D

export var speed = 500 # vitesse de l'asteroide
var velocite = Vector2() # vecteur de mouvement 


# crée une balle
func creer(pos,dir):
	position = pos
	rotation = dir
	velocite = Vector2(speed, 0).rotated(dir)


# fonction relative au physique (une fois par frame)
func _physics_process(delta):
	var collision = move_and_collide(velocite*delta)
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit()



# fonction appelée quand sorti de l'écran
func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # détruit le noeud
