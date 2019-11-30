extends Control

onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	GameState.connect("gameplay_started", self, "on_gameplay_started")
	#GameState.connect("gameplay_stopped", self, "on_gameplay_stopped")
	modulate.a = 0
	
	var points = GameState.PlayerWins
	$SecondPointPlayer/Indicator.modulate.a = 1 if points >= 2 else 0
	$FirstPointPlayer/Indicator.modulate.a = 1 if points >= 1 else 0
	
	points = GameState.AiWins
	$SecondPointAi/Indicator.modulate.a = 1 if points >= 2 else 0
	$FirstPointAi/Indicator.modulate.a = 1 if points >= 1 else 0

func on_gameplay_started():
	animation_player.play("show")
