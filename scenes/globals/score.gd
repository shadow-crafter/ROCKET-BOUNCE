extends Node

signal score_changed(new_value: int)
signal highscore_changed(new_value: int)

var score: int = 0
var highscore : int = 0 #save if possible?

func update_score(new_score: int):
	if new_score > score:
		score = new_score
		
	score_changed.emit(score)

func update_highscore():
	if score > highscore:
		highscore = score
		highscore_changed.emit(highscore)
