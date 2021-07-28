extends Control



func _on_Level1_pressed():
	PlayerSignal.level_selection = 0
	get_tree().change_scene("res://src/Game/Game.tscn")


func _on_Level2_pressed():
	PlayerSignal.level_selection = 1
	get_tree().change_scene("res://src/Game/Game.tscn")
