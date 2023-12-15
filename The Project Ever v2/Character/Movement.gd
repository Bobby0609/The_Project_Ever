extends State

class_name MoveState

@export var jump_velocity : float = -300.0
@export var walk_animation : String = "Walk"
@export var sprint_animation : String = "Sprint"
@export var idle_animation : String = "Idle"


func state_process(delta):
	pass
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("left") or event.is_action_pressed("right")):
		walk()
			
	if(event.is_action_pressed("Sprint")):
		sprint()
	
	elif event.is_action_released("Sprint"):
		walk()

func walk():
	playback.travel(walk_animation)

func sprint():
	playback.travel(sprint_animation)

func idle():
	playback.travel(idle_animation)
