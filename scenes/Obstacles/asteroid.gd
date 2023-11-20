class_name asteroid extends RigidBody2D

@export var min_speed: float
@export var max_speed: float

@export var rotation_speed_min: float
@export var rotation_speed_max: float

var direction: float
var rotation_speed : float

@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	scale *= randf_range(0.5, 1.5)
	sprite.frame = randi_range(0, 3)
	
	rotation_speed = deg_to_rad(randf_range(rotation_speed_min, rotation_speed_max))
	
	linear_velocity = Vector2(randf_range(min_speed, max_speed), 0).rotated(rotation)

func _process(delta: float) -> void:
	sprite.rotate(rotation_speed * delta)

func _on_hitbox_body_entered(body: player) -> void:
	if body is player:
		body.hit_asteroid()
		
		var tween: Tween = create_tween()
		tween.tween_property(self, "scale", Vector2.ZERO, 0.4)
		tween.tween_callback(self.queue_free)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
