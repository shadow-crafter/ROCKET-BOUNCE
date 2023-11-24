extends Control

@onready var parallax: ParallaxBackground = $ParallaxBackground

func _process(delta: float) -> void:
	parallax.scroll_offset += Vector2(50, 50) * delta
	
	if Input.is_action_just_pressed("THEBUTTON"):
		get_tree().change_scene_to_file("res://scenes/game/game_scene.tscn")
