extends CharacterBody2D

const grav = 20
const jumpspeed = 300
const floor = Vector2(0,-1)
@export var speed = 40
var maxspeed =300
var screen_size
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size=get_viewport_rect().size
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.is_action_pressed("move_right"):
		velocity.x+= speed
	elif Input.is_action_pressed("move_left"):
		velocity.x-= speed
	else:
		velocity.x=0
	if Input.is_action_pressed("move_up"):
		if is_on_floor():
			velocity.y-=jumpspeed
		
	velocity.y+=grav
	if velocity.x > maxspeed:
		velocity.x=maxspeed
	if velocity.x < -maxspeed:
		velocity.x=-maxspeed
	move_and_slide()
	position += velocity * delta
	pass
