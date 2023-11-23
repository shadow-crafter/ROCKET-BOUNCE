extends CanvasLayer

@onready var score_label: Label = $Control/MarginContainer/ScoreLabel
@onready var restart_vbox: VBoxContainer = $Control/MarginContainer/RestartVbox
@onready var highscore_label: Label = $Control/MarginContainer/RestartVbox/HighScoreLabel

func _ready() -> void:
	Score.score_changed.connect(update_score_text)
	Score.highscore_changed.connect(update_high_score)

func update_score_text(new_score: int):
	score_label.text = "SCORE: " + str(new_score)

func update_high_score(new_highscore: int):
	restart_vbox.visible = true
	highscore_label.text = "HIGHSCORE: " + str(new_highscore)
