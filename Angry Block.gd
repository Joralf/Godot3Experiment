extends KinematicBody2D

# Constants
const acceleration = 20
const max_speed = 100
const start_speed = 80

# Initial values
var direction = 1
var velocity = Vector2(0, start_speed)

func _ready():
	$AnimatedSprite.play("default")

# Do this each tick
func _physics_process(delta):
	calculate_acceleration(direction)
	move_body_and_update_velocity()
	
# detect player collision
# todo figure this out, source: https://stackoverflow.com/questions/69728827/how-do-i-detect-collision-between-a-kinematicbody-2dplayer-node-and-a-rigidbod
func _on_body_entered(body):
	$AnimatedSprite.play("collide")
	if body is Player:
		body.damage()
	
func calculate_acceleration(dir):
	velocity.y = move_toward(velocity.y, max_speed * dir, acceleration)
	velocity.x = 0

func move_body_and_update_velocity():
	velocity = move_and_slide(velocity, Vector2.UP)
	if(velocity.y == 0):
		direction *= -1
