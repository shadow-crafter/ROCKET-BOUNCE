extends Node2D

@export var asteroid_scene: PackedScene

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_path1: Path2D = $Path1
@onready var spawn_path2: Path2D = $Path2

func _on_spawn_timer_timeout() -> void:
	var new_asteroid = asteroid_scene.instantiate()
