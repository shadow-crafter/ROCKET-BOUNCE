extends Node2D

@export var move_time: float = 1.5
@export var cycles_to_do: int = 4
@export var appearance_threshold: int = 150

var cycles: int
var count: float = 0.0

@onready var movement_spots: Array[Marker2D] = [$MovementSpots/Left,
												$MovementSpots/Middle,
												$MovementSpots/Right]

@onready var plr: player = get_tree().get_first_node_in_group("Player")
@onready var current_spot: Marker2D = $MovementSpots/Middle
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var cycle_timer: Timer = $CycleTimer
@onready var animator: AnimationPlayer = $Animator

func _process(delta: float) -> void:
	if Score.score % appearance_threshold == 0 and Score.score > 1:
		if cycle_timer.is_stopped():
			start_ufo()
	ufo_interaction(delta)

func start_ufo() -> void:
	animator.play("fly_in")
	await animator.animation_finished
	
	cycles = cycles_to_do
	cycle_timer.start()

func ufo_interaction(delta: float) -> void:
	count += 4.0 * delta
	sprite.offset.y = sin(count) * 2.0
	global_position.y = -34 + plr.position.y
	
	if not cycle_timer.is_stopped():
		plr.position.x = sprite.global_position.x

func move_ufo() -> void:
	cycles -= 1
	
	if cycles <= 0:
		if 1 > movement_spots.find(current_spot):
			sprite.play("Right_Blink")
		else:
			sprite.play("Left_Blink")
		
		await get_tree().create_timer(1).timeout
		
		var tween: Tween = create_tween()
		tween.tween_property(sprite, "position", movement_spots[1].position, move_time)
		
		await tween.finished
		
		cycle_timer.stop()
		
		sprite.play("Idle")
		animator.play("fly_out")
	else:
		var go_to: Marker2D = current_spot
		while go_to == current_spot:
			go_to = movement_spots.pick_random()

		if movement_spots.find(go_to) > movement_spots.find(current_spot):
			sprite.play("Right_Blink")
		else:
			sprite.play("Left_Blink")
		
		await get_tree().create_timer(1).timeout
		
		var tween: Tween = create_tween()
		tween.tween_property(sprite, "position", go_to.position, move_time)
		
		await tween.finished
		
		sprite.play("Idle")
		current_spot = go_to

func _on_cycle_timer_timeout() -> void:
	move_ufo()
