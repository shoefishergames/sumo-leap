extends "res://scripts/Sumo.gd"

var min_delay
var max_delay
var max_angle_difference
var delay = 0.5

func _ready():
	$Sumo.pick_red()
	match GameState.Difficulty:
		GameState.Difficulties.EASY:
			min_delay = 0.4
			max_delay = 1.5
			max_angle_difference = PI / 2
		GameState.Difficulties.MEDIUM:
			min_delay = 0.4
			max_delay = 1.2
			max_angle_difference = PI / 3
		GameState.Difficulties.HARD:
			min_delay = 0.3
			max_delay = 1.0
			max_angle_difference = PI / 4

func _process(delta):
	handle_ai(delta)
	
	.process(delta, $Sumo/LeapIntensity)

func out_of_bounds():
	GameState.PlayerWins += 1
	
func leap_end():
	$Sumo.leap_end()

func handle_ai(delta: float):
	if GameState.CurrentState != GameState.States.GAMEPLAY:
		return

	delay -= delta
	
	if delay < 0:
		var target_angle = calc_angle_to_other_player($"../Player1")
		var difference = (randf() * max_angle_difference) - (max_angle_difference / 2)
		target_angle += difference
		
		$Sumo.leap_start()
		jump_at(target_angle, (intensity + 0.33) * jump_factor)
		
		delay = (randf() * max_delay) + min_delay

func _physics_process(delta):
	return .physics_process(delta, $"../Player1")
