extends KinematicBody2D

var speed = 300
var grav = 4000
var jump = -1000

var velocity: Vector2

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("left"):
		velocity.x -= speed
	if Input.is_action_pressed("right"):
		velocity.x += speed

func _process(delta):
	get_input()
	velocity.y += grav * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
			if is_on_floor():
				velocity.y = jump
