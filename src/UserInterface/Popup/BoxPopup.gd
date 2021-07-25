extends Control



func _on_CloseBtn_pressed():
	get_tree().paused = false
	queue_free()
