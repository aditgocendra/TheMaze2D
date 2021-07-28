extends Control

onready var pop_up = load("res://src/UserInterface/Popup/BoxPopup.tscn")


func _on_Adventure_pressed():
	get_tree().change_scene("res://src/UserInterface/SelectCharacter/SelectCharacter.tscn")


func _on_Quit_pressed():
	get_tree().quit()


func _on_CreditBtn_pressed():
	get_tree().change_scene("res://src/UserInterface/Credits/Credits.tscn")


func _on_Options_pressed():
	self.add_child(pop_up.instance())
	get_tree().paused = true


func _on_Multiplayer_pressed():
	self.add_child(pop_up.instance())
	get_tree().paused = true


func _on_AboutBtn_pressed():
	get_tree().change_scene("res://src/UserInterface/About/About.tscn")
