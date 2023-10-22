extends CharacterBody2D

const grav = 16
const jumpspeed = 300
const floor = Vector2(0,-1)
@export var speed = 40
var maxspeed =300
var screen_size
var jumpcount
var dashing
var dash_duration = 0
var max_dash_duration = .15
var dash_speed = 450
var last_velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size=get_viewport_rect().size
	dashing = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if is_on_floor():
		jumpcount =1

	
	if dashing:
		
		dash_duration += delta
		velocity = last_velocity
		if dash_duration >= max_dash_duration || velocity.x == 0:
			dashing = false
			
			dash_duration = 0
	else:
	
		if Input.is_action_just_pressed("dash") && Input.is_action_pressed("move_right") && jumpcount>0:
			dashing = true
			velocity.x= dash_speed
			velocity.y=0
			if !is_on_floor():
				jumpcount-=1
		elif Input.is_action_just_pressed("dash") && Input.is_action_pressed("move_left")&& jumpcount>0:
			dashing = true
			velocity.x= -dash_speed
			velocity.y=0
			if !is_on_floor():
				jumpcount-=1
		else:
			
			if Input.is_action_pressed("move_right"):
				velocity.x+= speed
			elif Input.is_action_pressed("move_left"):
				velocity.x-= speed
			else:
				velocity.x=0
			if Input.is_action_just_pressed("move_up"):
				if  jumpcount > 0:
					velocity.y= -jumpspeed
					if !is_on_floor():
						jumpcount-=1
			
			velocity.y+=grav
			if velocity.x > maxspeed:
				velocity.x=maxspeed
			if velocity.x < -maxspeed:
				velocity.x=-maxspeed
	move_and_slide()
	position += velocity * delta
	last_velocity=velocity
	position = position.round()
	pass
