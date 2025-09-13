extends CharacterBody2D

signal new_round
signal moved

const SPEED = 256.0
const JUMP_VELOCITY = -400.0

var Menu_Open = false

func _on_machines_menu_open() -> void:
	Menu_Open = true
	
func _on_machines_menu_closed() -> void:
	Menu_Open = false

func _physics_process(delta: float) -> void: 
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Up") and Menu_Open == false:
		#velocity.y = JUMP_VELOCITY
		position.y += -1 * SPEED
		moved.emit()

	if Input.is_action_just_pressed("Left") and Menu_Open == false:
		#velocity.y = JUMP_VELOCITY
		position.x += -1 * SPEED
		moved.emit()
		
	if Input.is_action_just_pressed("Right") and Menu_Open == false:
		#velocity.y = JUMP_VELOCITY
		position.x += 1 * SPEED
		moved.emit()
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
		#position.x += direction * SPEED * delta
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_new_round_body_entered(body: Node2D) -> void:
	position.y += 1018
	new_round.emit()
