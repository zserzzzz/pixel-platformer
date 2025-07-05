extends CharacterBody2D

@onready var cd: Timer = $cd
@onready var ttm: Timer = $ttm

var direction

var gravity = Vector2(0,980.0)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 600


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("w") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	if ttm.time_left == 0:
		gravity = Vector2(0,980.0)
		walk_extra()
	
	if Input.is_action_just_pressed("dash") and cd.time_left == 0:
		print("dashed")
		direction = Input.get_axis("a", "d")
		velocity.x += direction * DASH_SPEED
		dash_extra()
	
	print(ttm.time_left,velocity)
	move_and_slide()


func dash_extra():
	cd.start()
	ttm.start()
	gravity = Vector2(0,0)
	
func walk_extra():
	direction = Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
