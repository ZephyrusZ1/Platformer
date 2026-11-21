extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var coins = 0
var more_animations = true
@onready var animations = $AnimatedSprite2D
@onready var counter = $"CanvasLayer/Coins counter"
@onready var health = $"CanvasLayer/health"
var healths = 5 

func _ready():
	Eventbus.death.connect(_on_death)
	update_counter()
	hide()
func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta

	if more_animations == true:
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
	update_counter()
	dead()
func _on_death():
	more_animations = false
	animations.play("death")
	await animations.animation_finished
	hide()
	Eventbus.killed.emit()

func update_counter():
	health.text = str(healths)
	counter.text = str(coins)
	
func dead():
	if healths <= 0:
		death()
		
func death():
	more_animations = false
	animations.play("death")
	await animations.animation_finished
	hide()
	Eventbus.killed.emit()
