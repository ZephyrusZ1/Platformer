extends Node2D

@onready var player = $Char
@onready var spawn = $Spawn_point
@export var ui: PackedScene

var ui_instance = null

func _ready() -> void:
	Eventbus.start.connect(_on_start)

	ui_instance = ui.instantiate()
	add_child(ui_instance)

func _on_boundary_body_entered(body: Node2D) -> void:
	if body.name == "Char":
		Eventbus.death.emit()

func _on_start() -> void:

	player.show()
	player.global_position = spawn.global_position
	player.move_lock = false
	player.health.show()
	Engine.time_scale = 1


func _on_char_killed():
	if not is_instance_valid(ui_instance):
		ui_instance = ui.instantiate()
		add_child(ui_instance)
	Eventbus.death.emit()
