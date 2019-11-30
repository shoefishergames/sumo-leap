extends Node

signal gameplay_started
signal gameplay_stopped

var PlayerWins = 0
var AiWins = 0
var CurrentState = States.INTRO
var Difficulty = Difficulties.EASY

enum States {
	INTRO,
	GAMEPLAY,
	OUT_OF_RING,
	END_OF_GAME
}

enum Difficulties {
	EASY,
	MEDIUM,
	HARD
}

func set_state(state) -> void:
	if CurrentState != States.GAMEPLAY && state == States.GAMEPLAY:
		emit_signal("gameplay_started")
	elif CurrentState == States.GAMEPLAY && state != States.GAMEPLAY:
		emit_signal("gameplay_stopped")
	
	CurrentState = state

func start_gameplay() -> void:
	set_state(States.GAMEPLAY)

func pushed_out_of_ring() -> void:
	set_state(States.OUT_OF_RING)

func end_of_game() -> void:
	PlayerWins = 0
	AiWins = 0
	set_state(States.END_OF_GAME)
	
func did_someone_win() -> bool:
	return did_player_win() || did_ai_win()

func did_player_win() -> bool:
	return PlayerWins >= 2

func did_ai_win() -> bool:
	return AiWins >= 2
