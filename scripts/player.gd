extends CharacterBody2D

@onready var scream: AudioStreamPlayer2D = $Scream

signal new_round
signal moved
signal scream_finished

const SPEED = 256.0
const JUMP_VELOCITY = -400.0

var Pause = false

var Screamed = false

var Menu_Open = false
var Game_Over = false

func _on_game_game_over() -> void:
	Game_Over = true
	Pause = true
	if Screamed == false:
		$Scream.play()
		Screamed = true

func _on_machines_menu_open() -> void:
	Menu_Open = true
	Pause = true
	
func _on_machines_menu_closed() -> void:
	Menu_Open = false
	Pause = false

func _on_game_menu_open() -> void:
	Pause = true

func _on_game_menu_closed() -> void:
	Pause = false

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void: 
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Up") and Pause == false:
		#velocity.y = JUMP_VELOCITY
		position.y += -1 * SPEED
		moved.emit()

	if Input.is_action_just_pressed("Left") and Pause == false:
		#velocity.y = JUMP_VELOCITY
		position.x += -1 * SPEED
		moved.emit()
		
	if Input.is_action_just_pressed("Right") and Pause == false:
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


@warning_ignore("unused_parameter")
func _on_new_round_body_entered(body: Node2D) -> void:
	position.y += 1018
	new_round.emit()

func _on_scream_finished() -> void:
	scream_finished.emit()
