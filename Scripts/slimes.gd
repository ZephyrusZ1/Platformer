extends Area2D
@onready var left = $RayCastleft
@onready var right = $RayCastright
@onready var below_right = $RayCast2Drightbelow
@onready var below_left = $RayCast2Dleftbelow
var damaging = true
const  speed = 60
var direction = 1
var going_left
func _ready() -> void:
	pass # Replace with function body.



func _process(delta):
	if left.is_colliding() or not below_left.is_colliding():
		direction = 1
		going_left = true
	if right.is_colliding()  or not below_right.is_colliding():
		direction = -1
		going_left = false
	
	position.x += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Char" and going_left == true:
		body.healths -= 1
		Eventbus.knockback.emit()
	elif body.name == "Char" and going_left == false:
		body.healths -= 1
		Eventbus.other_knockback.emit()



func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Char":
		
		body.velocity.y -= 600
		queue_free()
