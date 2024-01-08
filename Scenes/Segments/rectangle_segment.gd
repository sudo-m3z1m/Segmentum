extends RigidBody2D
class_name Segment

@export var health_points: int = 100

func take_damage(damage: int) -> void:
	if health_points - damage <= 0:
		queue_free()
	$ProgressBar.show()
	health_points -= damage
	$ProgressBar.value = health_points
	shake_segment()

func shake_segment() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "rotation", PI/24, 0.1)
