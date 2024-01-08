extends Node2D
class_name Weapon

@export var bullet_scene: PackedScene
@export var cooldown: float

func shoot() -> void:
	var new_bullet: Bullet = bullet_scene.instantiate()
	new_bullet.rotation = rotation
	new_bullet.global_position = global_position
	
	get_tree().current_scene.add_child(new_bullet)
