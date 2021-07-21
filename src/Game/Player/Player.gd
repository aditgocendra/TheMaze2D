extends KinematicBody2D


var speed = 80
var acceleration = 12
var friction = 12

var velocity = Vector2.ZERO
var direction = Vector2.ZERO

var is_dead = false


func _physics_process(delta):
	#calculate direction
	direction = Vector2.ZERO
	direction = get_direction().normalized()
	
	
	if direction != Vector2.ZERO:
		velocity += direction * acceleration * delta
		velocity = velocity.clamped(speed * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	move_and_collide(velocity)
	
	var anim = animated_player()
	$AnimatedSprite.play(anim)
	
	if $AnimatedSprite.animation == "Dead" and is_dead:
		yield($AnimatedSprite, "animation_finished")
		PlayerSignal.dead = true
		 
		
func animated_player():
	# flip horizontal with direction
	var animation
	
	if is_dead:
		animation = "Dead"
	else:
		if direction.x > 0:
			$AnimatedSprite.flip_h = false
		if direction.x < 0:
			$AnimatedSprite.flip_h = true
			
		if direction.x != 0 or direction.y != 0:
			animation = "Run"
		else: animation = "Idle"
	
	return animation

func get_direction() -> Vector2:
	if is_dead:
		return Vector2.ZERO
	else:
		return Vector2(
			Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
			Input.get_action_strength("move_bottom") - Input.get_action_strength("move_up")
		)

func die():
	is_dead = true

