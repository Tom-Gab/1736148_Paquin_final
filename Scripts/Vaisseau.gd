extends KinematicBody2D

var speed = 100
var health = 100
onready var audio = $AudioStreamPlayer
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
			
	get_input()
	var dir = get_global_mouse_position() - global_position
	if dir.length() > 5:
		rotation = dir.angle()
		velocity = move_and_slide(velocity)

func hit(integra):
		health = health - integra
		print(health)
		get_node("CollisionShape2D").set_deferred("disabled",true)
		yield(get_tree().create_timer(2.0),"timeout")
		get_node("CollisionShape2D").set_deferred("disabled",false)
		get_node("Lifebar/TextureProgress").value = health



func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("droite"):
		velocity.x += 1
		
	if Input.is_action_pressed("gauche"):
		velocity.x -= 1
		
	if Input.is_action_pressed("recule"):
		velocity.y += 1
		
	if Input.is_action_pressed("avance"):
		velocity.y -= 1
		
	if Input.is_action_just_pressed("shoot"):
		var b = bullet.instance()
		b.creer(cannon.global_position, rotation)
		get_parent().add_child(b)
		audio.play()
		
	velocity = velocity.normalized() * speed

