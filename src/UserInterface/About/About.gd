extends Control

onready var pop_up = load("res://src/UserInterface/Popup/BoxPopup.tscn")

func _on_BtnReview_pressed():
	OS.shell_open("https://play.google.com/store/apps/details?id=org.arkgames.soulmaze")


func _on_BackButton_pressed():
	get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")


func _on_AdsView_pressed():
	self.add_child(pop_up.instance())
	get_tree().paused = true


func _on_Donation_pressed():
	self.add_child(pop_up.instance())
	get_tree().paused = true


func _on_Share_pressed():
	self.add_child(pop_up.instance())
	get_tree().paused = true
