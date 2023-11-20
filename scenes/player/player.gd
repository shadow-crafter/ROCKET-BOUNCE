class_name player extends CharacterBody2D

@export var bounce_speed: float = 100.0

@export var GRAVITY: float = 100.0
@export var TERMINAL_VEL: float = 150.0

@onready var sprite: Sprite2D = $Sprite
@onready var bounce_timer: Timer = $BounceCooldown
@onready var fire_emitter: GPUParticles2D = $FireParticle
@onready var bounce_sound: AudioStreamPlayer2D = $BounceSound
@onready var rocket_bgsound: AudioStreamPlayer2D = $RocketBg

func _physics_process(delta: float) -> void:
	move_player(delta)

func move_player(delta: float) -> void:
	velocity.y = move_toward(velocity.y, TERMINAL_VEL, GRAVITY * delta)
	
	player_jump()
	
	move_and_slide()

func player_jump() -> void:
	if Input.is_action_just_pressed("THEBUTTON") and bounce_timer.is_stopped():
		velocity.y = -bounce_speed
		
		bounce_sound.pitch_scale = 1 + randf_range(-0.1, 0.1)
		bounce_sound.play()
		
		fire_emitter.emitting = false
		rocket_bgsound.stop()
		
		bounce_timer.start()
		await get_tree().create_timer(1).timeout
		fire_emitter.emitting = true
		rocket_bgsound.play()

func hit_asteroid() -> void:
	pass
