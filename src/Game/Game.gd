extends Node2D

onready var dark_map = preload("res://src/Game/Map/Adventure/Level1/DarkMap.tscn").instance()
onready var light_map = preload("res://src/Game/Map/Adventure/Level1/LightMap.tscn").instance()

onready var map_node = $Map
onready var animation_player = $UserInterface/AnimationPlayer 
onready var dialog_timer = $UserInterface/DialogContainer/DialogTimer

onready var text_dialog = $UserInterface/DialogContainer/HBoxContainer/DialogBackground/TextDialog
var text
var dead_text
var gold_chest_text
var empty_chest_text


func _ready():
# warning-ignore:return_value_discarded
	PlayerSignal.connect("player_dead", self, "_on_player_dead")
# warning-ignore:return_value_discarded
	PlayerSignal.connect("player_win", self, "_on_player_win")
# warning-ignore:return_value_discarded
	PlayerSignal.connect("player_empty_chest", self, "_on_player_empty_chest")
	get_dialog_chest()
	
	map_node.add_child(dark_map)
	if check_show_dialog():
		animation_player.play("show_dialog")
	
	
func _input(event):
	if event.is_action_pressed("change_map"):
		animation_player.play("trans_map")
		get_tree().paused = true
		
		
func change_map():
	var player_pos = map_node.get_child(0).get_node("Player").position
		
	var new_map : Node2D
	if map_node.get_child(0).name == "DarkMap":
		new_map = light_map
	else: new_map = dark_map
		
	map_node.remove_child(map_node.get_child(0))
		
	new_map.get_node("Player").position = player_pos
	map_node.add_child(new_map)
	
	
func check_show_dialog():
	text = map_node.get_child(0).dialog_text
	dead_text = map_node.get_child(0).on_dead_dialog
	if text != null:
		return true
	else: return false


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "trans_map":
		if check_show_dialog():
			animation_player.play("show_dialog")
		else : get_tree().paused = false
		
	if anim_name == "show_dialog":
		text_dialog.set_bbcode(text)
		text_dialog.set_visible_characters(0)
		dialog_timer.start()
		
	if anim_name == "dead_dialog":
		text_dialog.set_bbcode(dead_text)
		text_dialog.set_visible_characters(0)
		dialog_timer.start()
		
	if anim_name == "win_dialog":
		text_dialog.set_bbcode(gold_chest_text)
		text_dialog.set_visible_characters(0)
		dialog_timer.start()
		
	if anim_name == "empty_chest_dialog":
		text_dialog.set_bbcode(empty_chest_text)
		text_dialog.set_visible_characters(0)
		dialog_timer.start()
		
		
func _on_DialogTimer_timeout():
	text_dialog.set_visible_characters(text_dialog.get_visible_characters() + 1)
	
	if PlayerSignal.dead:
		if text_dialog.get_visible_characters() >= dead_text.length():
			dialog_timer.stop()
	elif PlayerSignal.win:
		if text_dialog.get_visible_characters() >= gold_chest_text.length():
			dialog_timer.stop()
	elif PlayerSignal.empty_chest:
		if text_dialog.get_visible_characters() >= empty_chest_text.length():
			dialog_timer.stop()
	else:
		if text_dialog.get_visible_characters() >= text.length():
			dialog_timer.stop()
		
		
func _on_DialogBtn_pressed():
	get_tree().paused = false
	animation_player.play("hide_dialog")
	text_dialog.set_bbcode(" ")
	
	if PlayerSignal.dead or PlayerSignal.win:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://src/UserInterface/MainMenu/MainMenu.tscn")
		PlayerSignal.win = false
		PlayerSignal.dead = false
	else:
		if text != null:
			map_node.get_child(0).change_show_dialog()

func get_dialog_chest():
	var data = Database.loadData()
	gold_chest_text = data["dialog"]["chest-dialog"]["chest_gold"]
	empty_chest_text = data["dialog"]["chest-dialog"]["chest_empty"]
	
	
func _on_player_dead():
	if not animation_player.is_playing() and PlayerSignal.dead:
		animation_player.play("dead_dialog")
		get_tree().paused = true
		
		
func _on_player_win():
	if not animation_player.is_playing() and PlayerSignal.win:
		animation_player.play("win_dialog")
		get_tree().paused = true
	
	
func _on_player_empty_chest():
	if not animation_player.is_playing() and PlayerSignal.empty_chest:
		animation_player.play("empty_chest_dialog")
		get_tree().paused = true
