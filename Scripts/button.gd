extends CanvasLayer

@export var level_path1: String
@export var level_path2: String
@export var level_path3: String
func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	pass

func _on_level_1_pressed() -> void:
	if level_path1 != "":
		get_tree().change_scene_to_file(level_path1)
		


func _on_level_2_pressed() -> void:
	if level_path2 != "":
		get_tree().change_scene_to_file(level_path2)


func _on_level_3_pressed() -> void:
	if level_path3 != "":
		get_tree().change_scene_to_file(level_path3)
