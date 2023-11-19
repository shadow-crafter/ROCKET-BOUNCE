extends CharacterBody2D

@export var bounce_speed: float = 100.0

@export var GRAVITY: float = 100.0
@export var TERMINAL_VEL: float = 150.0

@onready var sprite: Sprite2D = $Sprite

func _physics_process(delta: float) -> void:
	move_player(delta)

func move_player(delta: float) -> void:
	velocity.y = move_toward(velocity.y, TERMINAL_VEL, GRAVITY * delta)
	
	player_jump()
	
	move_and_slide()

func player_jump() -> void:
	if Input.is_action_just_pressed("THEBUTTON"):
		velocity.y = -bounce_speed
