extends Control

var selection = 0

onready var name_character = $Container/PanelNameChar/NameCharacter
onready var tween_character = $TweenCharacter
onready var container_character = $ContainerCharacter

func _on_LeftArrrow_pressed():
	if selection != 0:
		selection -= 1
		trans_character(70)
	change_character(selection)
	
	
func _on_RightArrow_pressed():
	if selection < 1:
		selection += 1
		trans_character(-70)
	change_character(selection)
	
	
func change_character(selected):
	if selected == 0:
		name_character.text = "Redhat"
		
	else: 
		name_character.text  = "Warrior"
		
	
	
	

func trans_character(next_pos):
	var goal_pos = Vector2(container_character.rect_position.x + next_pos, container_character.rect_position.y)
	tween_character.interpolate_property(container_character, "rect_position", container_character.rect_position, goal_pos, 1, tween_character.TRANS_LINEAR, tween_character.EASE_IN_OUT)
	tween_character.start()


func _on_EnterGame_pressed():
	if selection == 0:
		PlayerSignal.character_selection = "Redhat"
	else: PlayerSignal.character_selection = "Warrior"
	get_tree().change_scene("res://src/Game/Game.tscn")
