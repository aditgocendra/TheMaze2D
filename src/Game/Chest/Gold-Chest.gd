extends Area2D



func _on_AreaChestGold_body_entered(body):
	if body.name == "Player":
		PlayerSignal.win = true
