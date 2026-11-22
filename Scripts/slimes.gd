extends Area2D
@onready var left = $RayCastleft
@onready var right = $RayCastright
@onready var below_right = $RayCast2Drightbelow
@onready var below_left = $RayCast2Dleftbelow
var damaging = true
const  speed = 60
var direction = 1
func _ready() -> void:
	pass # Replace with function body.



func _process(delta):
	if left.is_colliding() or not below_left.is_colliding():
		direction = 1
	if right.is_colliding()  or not below_right.is_colliding():
		direction = -1
	
	position.x += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Char":
		body.healths -= 1
		Eventbus.knockback.emit()



func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Char":
		queue_free()
		body.velocity.y -= 200
