extends Node2D

onready var get_map = get_parent().get_parent()

func _ready():
	if get_map.type_map == "DarkMap":
		$AnimationPlayer.play("play_trap")
	else: $AnimationPlayer.play("idle_trap")


func _on_AreaHitTrap_body_entered(body):
	if body.name == "Player":
		body.die()


func _on_AreaHitTrap2_body_entered(body):
	if body.name == "Player":
		body.die()


func _on_AreaHitTrap3_body_entered(body):
	if body.name == "Player":
		body.die()


func _on_AreaHitTrap4_body_entered(body):
	if body.name == "Player":
		body.die()


func _on_AreaHitTrap5_body_entered(body):
	if body.name == "Player":
		body.die()

