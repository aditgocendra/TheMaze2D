extends Control



func _on_Start_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/UserInterface/AdventureMenu/AdventureMenu.tscn")


func _on_Quit_pressed():
	get_tree().quit()
