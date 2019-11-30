extends Spatial

onready var animationPlayer = $Camera/AnimationPlayer
onready var player1Intensity = $Player1/Sumo/LeapIntensity
onready var player2Intensity = $Player2/Sumo/LeapIntensity

func _ready():
	animationPlayer.connect("animation_finished", self, "animation_finished")
	GameState.connect("gameplay_started", self, "gameplay_started")
	GameState.connect("gameplay_stopped", self, "gameplay_stopped")

func animation_finished(animation_name: String) -> void:
	GameState.start_gameplay()

func gameplay_started():
	player1Intensity.visible = true
	player2Intensity.visible = true

func gameplay_stopped():
	player1Intensity.visible = false
	player2Intensity.visible = false
