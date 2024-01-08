extends Area2D
class_name Bullet

@export var speed: float = 300
@export var damage: int

var velocity: Vector2

func _ready():
	velocity = Vector2.RIGHT.rotated(rotation) * speed
	body_entered.connect(check_collisions)

func _physics_process(delta) -> void:
	move()

func move():
	global_position += velocity

func check_collisions(body) -> void:
	body.take_damage(damage)
	queue_free()
