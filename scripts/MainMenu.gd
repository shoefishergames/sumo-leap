extends Control

func _ready():
	$PlayButton.connect("button_down", self, "_play")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_play()
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _play():
	if $EasyButton.pressed:
		GameState.Difficulty = GameState.Difficulties.EASY
	elif $MediumButton.pressed:
		GameState.Difficulty = GameState.Difficulties.MEDIUM
	else:
		GameState.Difficulty = GameState.Difficulties.HARD

	get_tree().change_scene("res://scenes/Level.tscn")
