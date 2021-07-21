extends Node2D

export var type_map : String

onready var timer = $CanvasLayer/Timer
onready var progress_timer = $CanvasLayer/ProgressTimer
onready var player = $Player
var dialog_text 
var on_dead_dialog
var data

func _ready():
	data = Database.loadData()
	get_dialog(data["dialog"]["light-map"])
	
func get_dialog(data_dialog):
	if data_dialog["show"] == false:
		dialog_text = data_dialog["text"]
	else: dialog_text = null
	
	on_dead_dialog = data_dialog["on-dead"]
	

func _on_Timer_timeout():
	if progress_timer.value > 0:
		progress_timer.value -= 0.1 
		timer.start()


func change_show_dialog():
	data["dialog"]["light-map"]["show"] = true
	Database.save_data(data)
	get_dialog(data["dialog"]["light-map"])



func _on_ProgressTimer_value_changed(value):
	if value <= 0:
		player.die()
	
