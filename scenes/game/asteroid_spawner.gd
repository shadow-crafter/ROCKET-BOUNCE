extends Node2D

@export var asteroid_scene: PackedScene

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_paths: Array[Path2D] = [$Path1, $Path2]
@onready var plr: player = get_tree().get_first_node_in_group("Player")

func _on_spawn_timer_timeout() -> void:
	var new_asteroid: asteroid = asteroid_scene.instantiate()
	
	var spawn_path: PathFollow2D = spawn_paths.pick_random().get_child(0)
	
	spawn_path.progress_ratio = randf()
	
	var direction: float = (spawn_path.rotation + PI / 2) + randf_range(0, PI / 6)
	#var direction: float = spawn_path.get_angle_to(plr.position)
	
	new_asteroid.position = spawn_path.position + plr.position + plr.velocity
	new_asteroid.rotation = direction
	new_asteroid.direction = direction
	
	get_tree().get_first_node_in_group("AsteroidContainer").add_child(new_asteroid)
