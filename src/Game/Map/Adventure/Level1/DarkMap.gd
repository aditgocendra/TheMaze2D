extends Node2D

export var type_map : String


var dialog_text 
var on_dead_dialog
var data


func _ready():
	data = Database.loadData()
	get_dialog(data["dialog"]["dark-map"])
	
func get_dialog(data_dialog):
	if data_dialog["show"] == false:
		dialog_text = data_dialog["text"]
	else: dialog_text = null
	
	on_dead_dialog = data_dialog["on-dead"]


func change_show_dialog():
	data["dialog"]["dark-map"]["show"] = true
	Database.save_data(data)
	get_dialog(data["dialog"]["dark-map"])
