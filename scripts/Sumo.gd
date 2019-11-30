extends KinematicBody

var zero = float(0)
var dodge_amount = 13
var jump_factor = 16
var intensity = randf()
var velocity = Vector3()

var jumping = false
var jump_after = 0
var jump_angle: float
var jump_intensity: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func process(delta, leap_intensity: ColorRect):
	if GameState.CurrentState != GameState.States.GAMEPLAY:
		return

	update_intensity(delta, leap_intensity)
	check_bounds()
	
	if jump_after > 0:
		jump_after -= delta
		if jump_after <= 0:
			jumping = true
			set_velocity(jump_angle, jump_intensity)
			jump_after = 0
	
	if jumping:
		if abs(velocity.x) < 10 && abs(velocity.z) < 10:
			leap_end()
			jumping = false

func check_bounds():
	if not $"../Area".overlaps_body(self):
		GameState.pushed_out_of_ring()

		out_of_bounds()
		if GameState.did_someone_win():
			get_tree().change_scene("res://scenes/GameEnd.tscn")
		else:
			get_tree().reload_current_scene()

func out_of_bounds():
	pass
	
func leap_end():
	pass

func physics_process(delta: float, other_player: KinematicBody):
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		collide(collision)
	
	velocity.x = reduce(velocity.x)
	velocity.z = reduce(velocity.z)
	
	translation.y = 2.754
	var target_angle = calc_angle_to_other_player(other_player)
	rotation.y = (PI * 2) - target_angle - (PI/2)

func collide(collision: KinematicCollision):
	pass
	
func jump_at(target:float, intensity:float):
	jump_after = 0.1
	jump_angle = target
	jump_intensity = intensity

func reduce(value: float) -> float:
	if value > 0:
		if value < 1:
			return zero
		else:
			return value - 1
	elif value < 0:
		if value > -1:
			return zero
		else:
			return value + 1

	return zero

func set_velocity(target_angle: float, force: float):
	var x = force * cos(target_angle)
	var y = force * sin(target_angle)
	
	velocity = Vector3(-x, 0, -y)

func calc_angle_to_other_player(other_player: KinematicBody) -> float:
	return calc_angle(other_player.get_translation())

func calc_angle(other_pos: Vector3) -> float:
	var current_pos = get_translation()
	var current_vector2 = Vector2(current_pos.x, current_pos.z)
	var other_vector2 = Vector2(other_pos.x, other_pos.z)
	return current_vector2.angle_to_point(other_vector2)

func update_intensity(delta, leap_intensity: ColorRect):
	var screenPos = get_current_screen_pos()
	leap_intensity.set_position(Vector2(screenPos.x -50, screenPos.y - 50))
	
	intensity += delta / 1.5 # Delta = amount of seconds since last frame
	if intensity > 1:
		intensity -= 1
	
	leap_intensity.get_node("Amount").rect_size.x = intensity * 100

func get_current_screen_pos() -> Vector2:
	var pos = get_translation()
	var cam = get_tree().get_root().get_camera()
	return cam.unproject_position(pos)
