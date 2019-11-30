extends Control

onready var startButton = $StartGameButton
onready var mainMenuButton = $MainMenuButton
onready var label = $Label

export var accept_action = "ui_accept"

func _ready():
	if GameState.did_player_win():
		label.text = "Congratulations, you've won!"
		$Win.play()
	else:
		label.text = "Better luck next time :)"
		$Lose.play()
	
	GameState.end_of_game()
	
	startButton.connect("button_up", self, "start_button_pressed")
	mainMenuButton.connect("button_up", self, "main_menu_button_pressed")

func _input(event):
	if event.is_action_pressed(accept_action):
		start_button_pressed()

func start_button_pressed():
	get_tree().change_scene("res://scenes/Level.tscn")

func main_menu_button_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
