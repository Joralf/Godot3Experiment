extends KinematicBody2D

# CONSTANTS
const speed = 300
const gravity = 16
const jump_velocity = 550
const pound_velocity = 800
const bounce_factor = -20

# INITIAL VALUES
var velocity = Vector2.ZERO
var jump_allowed = true
var pound_allowed = true

# DO THIS EACH TICK
func _physics_process(delta):
	apply_gravity()
	apply_acceleration(1)
	
	if is_on_floor():
		velocity.y = get_bounce_velocity(velocity)
		jump_allowed = true
		pound_allowed = true
		
	if !is_on_floor() && Input.is_action_just_pressed("ui_up") && jump_allowed:
		velocity.y = get_jump_velocity(velocity)
		jump_allowed = false
		
	if !is_on_floor()  && Input.is_action_just_pressed("ui_down")  && pound_allowed:
		velocity.y = get_pound_velocity(velocity)
		pound_allowed = false
	
	velocity = move_and_slide(velocity, Vector2.UP)

func apply_gravity():
	velocity.y += gravity
	
func apply_acceleration(direction):
	velocity.x = move_toward(velocity.x, speed * direction, 10)

func get_jump_velocity(current_velocity):
	return current_velocity.y - jump_velocity
	
func get_pound_velocity(current_velocity):
	return pound_velocity
	
func get_bounce_velocity(current_velocity):
	return current_velocity.y * bounce_factor
