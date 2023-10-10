extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

@onready var sprite: Sprite2D = get_node("Knight") # MAKE SURE TO ENTER THE SPRITE NAME OF YOUR SPRITE
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var frame_counter = 30
var frame_duration = 0.1  # Adjust this to control the frame change speed

func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# Only move if arrow key inputs are received.
	var direction = 0
	
	if Input.is_action_pressed("Run"):
		if Input.is_action_pressed("ui_left"):
			direction -= 1
			velocity.x = SPEED * 2
		
		if Input.is_action_pressed("ui_right"):
			direction += 1
			velocity.x = SPEED * 2
	
	
	if Input.is_action_pressed("ui_left"):
		direction -= 1
		animate(0,7,delta)
			
	if Input.is_action_pressed("ui_right"):
		direction += 1

	if Input.is_action_just_pressed("ui_up"):
		velocity.y = JUMP_VELOCITY
	# Change the sprite frame every frame_duration seconds.
	

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func animate(start, end, delta):
	for frame in range(start, end+1):
		sprite.frame = frame
		# wait delta seconds

	
