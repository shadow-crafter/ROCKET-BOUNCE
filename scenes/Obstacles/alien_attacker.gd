extends Node2D

"""
UFO
flies into middle of frame. after a second, fires a translucent beam over the player.
every [4-8] seconds, move to a random spot, bringing the player with them.
lights flash to indicate what direction it will move before it does. (like turn signal)

goes away after 5 cycles. The UFO returns every [200] score.
final cycle brings you back to center.
"""
var cycles: int = 0
var count: float = 0.0

@onready var movement_spots: Array[Marker2D] = [$MovementSpots/Left, $MovementSpots/Middle, $MovementSpots/Right]
@onready var current_spot: Marker2D = $MovementSpots/Middle
@onready var sprite: Sprite2D = $Sprite
@onready var animator: AnimationPlayer = $Animator

func _ready() -> void:
	animator.play("fly_in")
	await animator.animation_finished
	#animator.play("idle")

func _process(delta: float) -> void:
	count += 4.0 * delta
	sprite.offset.y = sin(count) * 2.0

func _on_cycle_timer_timeout() -> void:
	cycles += 1
	
	if cycles > 5:
		var tween: Tween = create_tween()
		tween.tween_property(sprite, "position", movement_spots[1].position, 1.2)
		
		await tween.finished
		
		animator.play("fly_out")
	else:
		var go_to: Marker2D = current_spot
		while go_to == current_spot:
			go_to = movement_spots.pick_random()

		var tween: Tween = create_tween()
		tween.tween_property(sprite, "position", go_to.position, 1.2)
		
		current_spot = go_to
