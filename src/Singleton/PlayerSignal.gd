extends Node


signal player_dead
signal player_win
signal player_empty_chest



var dead = false setget on_dead
var win = false setget on_win
var empty_chest = false setget on_chest_empty

var character_selection = "Redhat"
var level_selection = 0

func on_dead(_dead):
	dead = _dead
	emit_signal("player_dead")

func on_win(_win):
	win = _win
	emit_signal("player_win")

func on_chest_empty(_empty_chest):
	empty_chest = _empty_chest
	emit_signal("player_empty_chest")


