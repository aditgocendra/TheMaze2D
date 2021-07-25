extends Control


func _on_BtnArt2D_pressed():
	OS.shell_open("https://www.gameart2d.com/")


func _on_BackButton_pressed():
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
