extends Node


#var db_path = "user://database.json"
var db_path = "res://src/Singleton/database.json"
var _file
var json_data

var default_data = {
			  "dialog": {
				"dark-map": {
				  "on-dead": "Nope!!!!, I forgot the traps scattered everywhere!!!",
				  "show": false,
				  "text": "Where the treasure is, I must find it!!, I can find treasure, by looking at it from a slightly different side of the world."
				},
				"light-map": {
				  "on-dead": "Please, I can't breathe, aaaaaaaaa",
				  "show": false,
				  "text": "Feels a little tight, I can't stay long in this unreal world."
				},
				"chest-dialog": {
				  "chest_gold": "Finally i found!!!!",
				  "chest_empty": "It seems that someone has entered this labyrinth."
				}
			  }
			}


func _ready():
	loadData()
	
	
func loadData():
	_file = File.new()
		
	if not _file.file_exists(db_path):
		save_data(default_data)
		return default_data
	else:
		_file.open(db_path, File.READ)
		
		json_data = parse_json(_file.get_as_text())
		
		if json_data.size() > 0:
			return json_data
			
			
func save_data(new_data):
	_file = File.new()
	
	_file.open(db_path, File.WRITE)
	_file.store_line(to_json(new_data))
	_file.close()
