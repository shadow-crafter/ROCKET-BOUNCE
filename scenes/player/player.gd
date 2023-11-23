class_name player extends CharacterBody2D

@export var bounce_speed: float = 100.0

@export var GRAVITY: float = 100.0
@export var TERMINAL_VEL: float = 150.0

var health: int = 3
var alive: bool = true
var bounce_alternate: bool = false

@onready var sprite: Sprite2D = $Sprite
@onready var animator: AnimationPlayer = $Animator
@onready var bounce_timer: Timer = $BounceCooldown
@onready var fire_emitter: GPUParticles2D = $FireParticle
@onready var bounce_sound: AudioStreamPlayer2D = $SoundContainer/BounceSound
@onready var rocket_bgsound: AudioStreamPlayer2D = $SoundContainer/RocketBg

func _physics_process(delta: float) -> void:
	if alive:
		move_player(delta)
		Score.update_score(round(position.y / 10))
	elif Input.is_action_just_pressed("THEBUTTON"):
		Score.score = 0
		get_tree().reload_current_scene()

func move_player(delta: float) -> void:
	velocity.y = move_toward(velocity.y, TERMINAL_VEL, GRAVITY * delta)
	
	player_jump()
	
	move_and_slide()

func player_jump() -> void:
	if Input.is_action_just_pressed("THEBUTTON") and bounce_timer.is_stopped():
		velocity.y = -bounce_speed
		
		bounce_sound.pitch_scale = 1 + randf_range(-0.1, 0.1)
		bounce_sound.play()
		
		bounce_timer.start()
		
		bounce_alternate = (not bounce_alternate)
		if bounce_alternate:
			animator.play("bounce1")
		else:
			animator.play("bounce2")

func hit_asteroid() -> void:
	health -= 1
	# OUCHY, CHANGE SPRITE TO CRACKING
	if health == 0:
		alive = false
		velocity = Vector2.ZERO
		
		Score.update_highscore()
		animator.play("die")
