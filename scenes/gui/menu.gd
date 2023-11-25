extends Control

@onready var parallax: ParallaxBackground = $ParallaxBackground

func _process(delta: float) -> void:
	parallax.scroll_offset += Vector2(50, 50) * delta
	
	if Input.is_action_just_pressed("THEBUTTON"):
		SceneTransition.change_scene("res://scenes/game/game_scene.tscn")
