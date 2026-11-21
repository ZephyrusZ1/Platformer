extends Area2D
@onready var left = $RayCastleft
@onready var right = $RayCastright

var damaging = true
const  speed = 60
var direction = 1
func _ready() -> void:
	pass # Replace with function body.



func _process(delta):
	if left.is_colliding():
		direction = 1
	if right.is_colliding():
		direction = -1
	position.x += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Char" and damaging == true:
		body.healths -= 1
		damaging = false
		await get_tree().create_timer(1).timeout
		damaging = true


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Char":
		queue_free()
