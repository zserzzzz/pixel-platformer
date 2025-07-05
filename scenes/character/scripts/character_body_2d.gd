extends CharacterBody2D

@onready var cd: Timer = $cd
@onready var ttm: Timer = $ttm
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var directionx
var directiony

var gravity = Vector2(0,980.0)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DASH_SPEED = 600


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	if ttm.time_left == 0:
		gravity = Vector2(0,980.0)
		animated_sprite_2d.play("default")
		walk_extra()
	
	if Input.is_action_just_pressed("dash") and cd.time_left == 0:
		print("dashed")
		directionx = Input.get_axis("a", "d")
		directiony = Input.get_axis("w","s")
		velocity = Vector2(directionx * DASH_SPEED,directiony * DASH_SPEED * 0.75)
		dash_extra()
		if directionx == -1:
			animated_sprite_2d.play("dash_left")
		else:
			animated_sprite_2d.play("dash_right")
		
	print(ttm.time_left,velocity)
	move_and_slide()


func dash_extra():
	cd.start()
	ttm.start()
	gravity = Vector2(0,0)
	
func walk_extra():
	directionx = Input.get_axis("a", "d")
	
	if directionx:
		velocity.x = directionx * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
