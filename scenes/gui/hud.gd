extends CanvasLayer

@onready var score_label: Label = $Control/MarginContainer/VBoxContainer/ScoreLabel
@onready var highscore_label: Label = $Control/MarginContainer/VBoxContainer/HighScoreLabel

func _ready() -> void:
	Score.score_changed.connect(update_score_text)
	Score.highscore_changed.connect(update_high_score)

func update_score_text(new_score: int):
	score_label.text = "SCORE: " + str(new_score)

func update_high_score(new_highscore: int):
	highscore_label.visible = true
	highscore_label.text = "HIGHSCORE: " + str(new_highscore)
