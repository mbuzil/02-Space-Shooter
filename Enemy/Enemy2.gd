extends KinematicBody2D
var health = 8

var y_positions = [250,300,350,400,450]
var initial_position = Vector2.ZERO
var direction = Vector2(4,-1)

var Effects = null
onready var Explosion = load("res://Effects/Explosion.tscn")

func _ready():
	initial_position.x = -100
	initial_position.y = y_positions[randi() % y_positions.size()]
	position = initial_position
	
func _physics_process(_delta):
	position += direction
	if position.x >= Global.VP.x + 100:
		position.x = -100
	position.y = wrapf(position.y, 0, Global.VP.y)

func damage(d):
	health -= d
	if health <= 0:
		Global.update_score(1000)
		#Global.killed_enemy()
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instance()
			Effects.add_child(explosion)
			explosion.global_position = global_position
		queue_free()
		
func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body.damage(100)
		damage(100)
