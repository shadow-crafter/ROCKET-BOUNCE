class_name asteroid extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	sprite.frame = randi_range(0, 3)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
