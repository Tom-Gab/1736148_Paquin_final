extends KinematicBody2D

var speed = 100
var health = 100
var velocity = Vector2()
export (PackedScene) var bullet
onready var cannon = $Position2D
onready var screen_size = get_viewport_rect().size


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity = Vector2()
	get_input()
	var collision = move_and_collide(velocity * delta)
	if collision:
		if health <= 0:
			Global.goto_scene("res://Scenes/Mort.tscn")
			
		if collision.collider.name == "boulette":
			health -= 5
			get_node("CollisionShape2D").set_deferred("disabled",true)
			yield(get_tree().create_timer(2.0),"timeout")
			get_node("CollisionShape2D").set_deferred("disabled",false)
			
		if collision.collider.name == "missile":
			health -= 10
			get_node("CollisionShape2D").set_deferred("disabled",true)
			yield(get_tree().create_timer(2.0),"timeout")
			get_node("CollisionShape2D").set_deferred("disabled",false)


	get_input()
	var dir = get_global_mouse_position() - global_position
	if dir.length() > 5:
		rotation = dir.angle()
		velocity = move_and_slide(velocity)


func get_input():
	if Input.is_action_pressed("droite"):
		velocity = Vector2(speed, 0).rotated(rotation)
		velocity.x += 1
		print("droite")
		
	if Input.is_action_pressed("gauche"):
		velocity = Vector2(speed, 0).rotated(rotation)
		velocity.x -= 1
		print("gauche")
		
	if Input.is_action_pressed("recule"):
		velocity = Vector2(speed, 0).rotated(rotation)
		velocity.y += 1
		print("recule")
		
	if Input.is_action_pressed("avance"):
		velocity = Vector2(speed, 0).rotated(rotation)
		velocity.y -= 1
		print("avance")
		
	if Input.is_action_just_pressed("shoot"):
		var b = bullet.instance()
		b.creer(cannon.global_position, rotation)
		get_parent().add_child(b)
