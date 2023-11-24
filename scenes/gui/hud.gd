extends CanvasLayer

var can_restart: bool = false

@onready var score_label: Label = $Control/MarginContainer/ScoreLabel
@onready var restart_vbox: VBoxContainer = $Control/MarginContainer/RestartVbox
@onready var highscore_label: Label = $Control/MarginContainer/RestartVbox/HighScoreLabel

func _ready() -> void:
	Score.score_changed.connect(update_score_text)
	Score.highscore_changed.connect(update_high_score)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("THEBUTTON") and can_restart:
		Score.score = 0
		get_tree().reload_current_scene()

func update_score_text(new_score: int):
	score_label.text = "SCORE: " + str(new_score)

func update_high_score(new_highscore: int):
	restart_vbox.visible = true
	highscore_label.text = "HIGHSCORE: " + str(new_highscore)
	
	await get_tree().create_timer(1).timeout
	can_restart = true
