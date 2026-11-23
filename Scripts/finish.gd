extends Area2D

@export var level_selection: String

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



	

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Char":
		if level_selection != "":
			get_tree().call_deferred("change_scene_to_file", level_selection)
