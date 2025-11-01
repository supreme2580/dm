class_name Player extends CharacterBody3D

const SPEED = 25.0
const TURN_SPEED = 3.0
const JUMP_VELOCITY = 10.0	

@onready var animationPlayer = $player/AnimationPlayer

func _process(_delta: float):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("x"):
		attack()


func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var forward = Input.is_action_pressed("ui_up")
	var backward = Input.is_action_pressed("ui_down")
	var turn_left = Input.is_action_pressed("ui_left")
	var turn_right = Input.is_action_pressed("ui_right")

	if turn_left:
		rotate_y(deg_to_rad(TURN_SPEED))
	elif turn_right:
		rotate_y(deg_to_rad(-TURN_SPEED))

	var direction = Vector3.ZERO
	if forward:
		direction -= transform.basis.z
	elif backward:
		direction += transform.basis.z

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		walk()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		stop_walking()

	move_and_slide()

	if not animationPlayer.is_playing():
		animationPlayer.play("idle_pet")


func walk():
	if not animationPlayer.is_playing() or animationPlayer.current_animation != "walk":
		animationPlayer.play("walk")


func stop_walking():
	if animationPlayer.is_playing() and animationPlayer.current_animation == "walk":
		animationPlayer.stop()
		animationPlayer.play("idle_pet")


func attack():
	if not animationPlayer.is_playing() or animationPlayer.current_animation != "attack":
		animationPlayer.play("slash_1")
