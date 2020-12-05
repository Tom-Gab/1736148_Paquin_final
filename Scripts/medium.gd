extends KinematicBody2D


const speed = 100
var velocity = Vector2()
export (PackedScene) var missile
onready var boom = $boom
var is_entered = null
var timer = null
onready var objectif = get_parent().get_node("Vaisseau")
var bullet_timer = 3
var anihilate = true
onready var bop = $Position2D
var bop2 = null
var bop3 = null


func _ready():
	if self.name == 'medium':
		var bop2 = $Position2D2
		var bop3 = $Position2D3
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(bullet_timer)
	timer.connect("timeout", self, "done")
	add_child(timer)
	
	
	
func _done():
	anihilate = true
	
	
func _physics_process(delta):
	if is_entered:
		var dir = (objectif.global_position - global_position).normalized()
		rotation = dir.angle()
		velocity = Vector2(speed, 0).rotated(rotation)
		move_and_slide(velocity)
		velocity = velocity.normalized()*speed
		
		
func hit():
	queue_free()
	Global.count -= 1


func _on_Area2D_body_entered(body):
	if body.name == "Vaisseau": 
		is_entered = true
		var b = missile.instance()
		b.creer(bop.global_position, rotation)
		get_parent().add_child(b)


func _on_Area2D_body_exited(body):
	if body.name == "Vaisseau": 
		is_entered = false
