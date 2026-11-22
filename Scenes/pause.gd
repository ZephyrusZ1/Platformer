extends CanvasLayer


@export var level_selection: String

func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		show()
		get_tree().paused = true


func _on_button_pressed() -> void:
	get_tree().paused = false
	hide()


func _on_button_2_pressed() -> void:
	get_tree().paused = false
	Eventbus.start.emit()
	hide()


func _on_button_3_pressed() -> void:
	get_tree().paused = false
	if level_selection != "":
		get_tree().change_scene_to_file(level_selection)
	hide()
