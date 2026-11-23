extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
var coins = 0
var more_animations = true
@onready var animations = $AnimatedSprite2D
@onready var counter = $"CanvasLayer/Coins counter"
@onready var health = $"CanvasLayer/health"
@onready var collision_shape = $CollisionShape2D
var healths = 5 
var damaged = false
var move_lock = true
var die = false
func _ready():
	Eventbus.death.connect(_on_death)
	Eventbus.knockback.connect(knockback)
	Eventbus.other_knockback.connect(other_knockback)
	update_counter()
	hide()
func _physics_process(delta: float) -> void:

	if not is_on_floor():
		velocity += get_gravity() * delta
	if move_lock == false:
		if damaged == false:
			if more_animations == true:
				if Input.is_action_pressed("right"):
					velocity.x = SPEED
					animations.play("walk")
					animations.flip_h = false
				elif Input.is_action_pressed("left"):
					velocity.x = -SPEED
					animations.play("walk")
					animations.flip_h = true
				elif Input.is_action_pressed("jump") and is_on_floor():
					velocity.y =  JUMP_VELOCITY
				else:
					velocity.x = 0
					velocity.y += 0
					animations.play("default")
		else:
			velocity.x = move_toward(velocity.x, 0, 15)
	move_and_slide()
	update_counter()
	dead()
	
func _on_death():
	more_animations = false
	$CanvasLayer.hide()
	Engine.time_scale = 0.5
	animations.play("death")
	await animations.animation_finished
	hide()
	Engine.time_scale = 1
	Eventbus.killed.emit()

func update_counter():
	health.text = str(healths)
	counter.text = str(coins)
	
func dead():
	if healths < 1:
		Eventbus.death.emit()

		
func death():
	more_animations = false
	animations.play("death")
	$CanvasLayer.hide()
	Engine.time_scale = 0.5
	await animations.animation_finished
	collision_shape.set_deferred("disabled", true)
	hide()
	Engine.time_scale = 1
	Eventbus.killed.emit()
	move_lock = true
	
	
func knockback():
	damaged = true
	animations.play("attacked")
	self.position.x -= 5
	self.position.y -=20
	await animations.animation_finished
	damaged = false
func other_knockback():
	damaged = true
	animations.play("attacked")
	self.position.x += 5
	self.position.y -=20
	await animations.animation_finished
	damaged = false
