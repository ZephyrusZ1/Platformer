extends CanvasLayer

static var skip_menu = false

func _ready() -> void:
	Eventbus.death.connect(game_over)
	if skip_menu == true:
		
		$start.hide()
		$game_over.hide()
		Eventbus.start.emit() 
	else:

		show()
		$start.show()
		$game_over.hide()

func _on_button_pressed():
	if $game_over.visible == true:
		skip_menu = true
		get_tree().paused = false 
		get_tree().reload_current_scene()
	else:
		$start.hide()
		Eventbus.start.emit()

func game_over():
	await get_tree().create_timer(1).timeout
	show()
	$game_over.show()
	$start.show()
