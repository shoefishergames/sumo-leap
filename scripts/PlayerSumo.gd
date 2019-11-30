extends "res://scripts/Sumo.gd"

var bounce_factor = 1.4
var cooldown = 0

func _ready():
	$Sumo.pick_blue()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_input()
	.process(delta, $Sumo/LeapIntensity)
	cooldown -= delta

func _physics_process(delta):
	return .physics_process(delta, $"../Player2")
	
func collide(collision: KinematicCollision):
	var other_player = $"../Player2"
	var other_velocity = other_player.velocity;
	other_player.velocity = velocity * bounce_factor
	velocity = other_velocity * bounce_factor

func out_of_bounds():
	GameState.AiWins += 1
	
func leap_end():
	$Sumo.leap_end()

func handle_input():
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if GameState.CurrentState != GameState.States.GAMEPLAY:
		return

	if cooldown > 0:
		return
		
	if Input.is_action_just_pressed("leap"):
		var clickPos = get_viewport().get_mouse_position()
		var screenPos = get_current_screen_pos()
		
		$Sumo.leap_start()
		jump_at(screenPos.angle_to_point(clickPos), (intensity + 0.33) * jump_factor)
		cooldown = .5

	if Input.is_action_just_pressed("ui_left"):
		var target_angle = calc_angle_to_other_player($"../Player2") - (PI / 2)
		set_velocity(target_angle, dodge_amount)
		cooldown = .2
	if Input.is_action_just_pressed("ui_right"):
		var target_angle = calc_angle_to_other_player($"../Player2") + (PI / 2)
		set_velocity(target_angle, dodge_amount)
		cooldown = .2

func get_current_screen_pos() -> Vector2:
	var pos = get_translation()
	var cam = get_tree().get_root().get_camera()
	return cam.unproject_position(pos)
