extends CharacterBody2D
class_name Player

@export var speed: float

var weapon: Weapon

func _input(event):
	if event.is_action_pressed("Attack"):
		weapon.shoot()

func _physics_process(delta) -> void:
	velocity = lerp(velocity, choose_direction() * speed, 0.3)
	rotate_weapon()

	move_and_slide()

func choose_direction() -> Vector2:
	var direction: Vector2 = Vector2.ZERO

	direction.x = Input.get_axis("Left", "Right")
	direction.y = Input.get_axis("Up", "Down")
	direction = direction.normalized()

	return direction

func rotate_weapon() -> void:
	if !weapon:
		return
	var mouse_position: Vector2 = get_global_mouse_position()
	weapon.rotation = get_angle_to(mouse_position)

func pick_weapon(weapons_area: Area2D) -> void:
	weapon = weapons_area.get_parent()
	get_tree().current_scene.remove_child(weapon)
	weapon.position = Vector2.ZERO
	call_deferred("add_child", weapon)
	weapon.get_node("Area2D/hit_box").set_disabled(true) #Need to change this

func drop_weapon() -> void:
	if !weapon:
		return
	var tween: Tween = create_tween()
	remove_child(weapon)
	
	get_tree().current_scene.call_deferred("add_child", weapon)
	var radius: float = 50
	var new_weapon_pos: Vector2
	new_weapon_pos.x = randf_range(-radius, radius)
	new_weapon_pos.y = randf_range(-radius, radius)
	new_weapon_pos += global_position
	
	weapon.global_position = global_position
	tween.tween_property(weapon, "global_position", new_weapon_pos, 0.3)
	
	var droped_weapon: Weapon = weapon
	
	await tween.finished
	droped_weapon.get_node("Area2D/hit_box").set_disabled(false) #Need to change this

func _on_area_2d_area_entered(area):
	if area.get_parent() is Weapon:
		drop_weapon()
		pick_weapon(area)
