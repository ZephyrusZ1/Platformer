extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var coins = 0
@onready var animations = $AnimatedSprite2D
@onready var counter = $"CanvasLayer/Coins counter"

func _ready():
	Eventbus.death.connect(_on_death)
func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta


	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		animations.play("walk")
		animations.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		animations.flip_h = true
	elif Input.is_action_pressed("jump") and is_on_floor():
		velocity.y =  JUMP_VELOCITY
	else:
		velocity.x = 0
		velocity.y += 0
		animations.play("default")
	move_and_slide()

func _on_death():
	print("you died")
	hide()

func update_counter():
	counter.text = str(coins)
