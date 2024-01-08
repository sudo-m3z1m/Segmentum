extends Segment
class_name Mob

@export var speed: float

@onready var first_segment: RigidBody2D = $RectangleSegment
@onready var second_segment: RigidBody2D = $RectangleSegment2
var direction: Vector2 = Vector2.RIGHT

func _physics_process(delta):
	position.x = clamp(position.x, 0, 1920)
	position.y = clamp(position.y, 0, 1080)

	linear_velocity = direction * speed

func _on_timer_timeout():
	direction = direction.rotated(PI/2)
#	rotation = lerp(rotation, rotation + PI/2, 0.1)
