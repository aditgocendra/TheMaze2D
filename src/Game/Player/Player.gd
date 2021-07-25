extends KinematicBody2D


var speed = 80
var acceleration = 12
var friction = 12

var velocity = Vector2.ZERO
var direction = Vector2.ZERO

var is_dead = false

onready var sprite_root = $SpriteRoot


func _ready():
	var instance_red_hat = preload("res://src/Game/Player/AnimatedSprite/RedHat.tscn").instance()
	var instance_warrior  = preload("res://src/Game/Player/AnimatedSprite/Warrior.tscn").instance()
	sprite_root.add_child(instance_warrior)


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
	sprite_root.get_child(0).play(anim)
	
	if sprite_root.get_child(0).animation == "Dead" and is_dead:
		yield(sprite_root.get_child(0), "animation_finished")
		PlayerSignal.dead = true
		 
		
func animated_player():
	# flip horizontal with direction
	var animation
	
	if is_dead:
		animation = "Dead"
	else:
		if sprite_root.get_child(0).name == "RedHat":
			
			if direction.x > 0:
				sprite_root.get_child(0).flip_h = false
			if direction.x < 0:
				sprite_root.get_child(0).flip_h = true
				
			if direction.x != 0 or direction.y != 0:
				animation = "Run"
		else:
			if direction.x > 0:
				animation = "RunRight"
			elif direction.x < 0:
				animation = "RunLeft"
			elif direction.y < 0:
				animation = "RunUp"
			else : animation = "RunBottom" 
			
		if direction.x == 0 and direction.y == 0:
			animation = "Idle"
	
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

