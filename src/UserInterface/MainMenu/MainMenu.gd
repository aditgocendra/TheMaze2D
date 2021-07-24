extends Control



func _on_Adventure_pressed():
	get_tree().change_scene("res://src/UserInterface/AdventureMenu/AdventureMenu.tscn")


func _on_Quit_pressed():
	get_tree().quit()
