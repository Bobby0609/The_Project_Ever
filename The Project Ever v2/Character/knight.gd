extends CharacterBody2D

@export var speed : float = 200.0
@export var jump_velocity : float = -300.0
@export var Walk : String = "Walk"

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : StateMachine = $StateMachine


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Get the input direction and handle the movement/deceleration
	# As a good practice, you should replace UI actiosn with custom gameplay actions
	direction = Input.get_vector("left", "right", "up", "down")
	
	# Control whether to move or not to move
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * velocity.x
	
	elif direction.x == 0:
		velocity.x = 0
		state_machine.current_state.playback.travel("Idle")
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if Input.is_action_pressed("Sprint") && direction.x != 0:
		speed = 350.0
		#state_machine.current_state.playback.travel("Sprint")
		
	else:
		speed = 200.0
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	animation_tree.set("parameters/Walk/blend_position", direction.x)
	
func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
