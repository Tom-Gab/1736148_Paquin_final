extends KinematicBody2D

export var vitesse = 500 # vitesse de l'asteroide
export var dbug = false # print ou non tous les collisions
var velocite = Vector2() # vecteur de mouvement 
var speed = 500


# crée une balle
func creer(pos,dir):
	position = pos
	rotation = dir
	velocite = Vector2(vitesse,0).rotated(dir)


# fonction relative au physique (une fois par frame)
func _physics_process(delta):
	var collision = move_and_collide(velocite*delta)
	if collision:
		if collision.collider.has_method("hit"):
			collision.collider.hit(collision)
			_on_VisibilityNotifier2D_screen_exited()
		velocite = velocite.bounce(collision.normal)



# fonction appelée quand sorti de l'écran
func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # détruit le noeud
