extends Node

signal Menu_Open
signal Menu_Closed
signal Eat
signal Broken
signal Fixed

@onready var ame_sprite: AnimatedSprite2D = $AME/AME_Sprite
@onready var singulo_sprite: AnimatedSprite2D = $Singulo/Singulo_Sprite
@onready var solar_sprite: AnimatedSprite2D = $Solar/Solar_Sprite
@onready var door_1_sprite: AnimatedSprite2D = $Doors/Door_1/Door_1_Sprite
@onready var door_2_sprite: AnimatedSprite2D = $Doors/Door_2/Door_2_Sprite
@onready var menus: AnimatedSprite2D = $"../Menus"

var AME_Broken = false
var Singulo_Broken = false
var Solar_Broken = false
var Door_1_Broken = false
var Door_2_Broken = false

var Ate = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func _on_food_body_entered(body: Node2D) -> void:
	if Ate == false:
		Eat.emit()
		Ate = true

func _on_new_round() -> void:
	
	Ate = false
	
	if randi_range(1,2) == 2:
		$AME/AME_Sprite.set_frame(1)
		AME_Broken = true
		Broken.emit()
		
	if randi_range(1,2) == 2:
		$Singulo/Singulo_Sprite.set_frame(1)
		Singulo_Broken = true
		Broken.emit()
		
	if randi_range(1,2) == 2:
		$Solar/Solar_Sprite.set_frame(1)
		Solar_Broken = true
		Broken.emit()
	
	if randi_range(1,2) == 2 and Door_1_Broken == false:
		$Doors/Door_1/Door_1_Sprite.play("default")
		Door_1_Broken = true
		Broken.emit()
		
	if randi_range(1,2) == 2 and Door_2_Broken == false:
		$Doors/Door_2/Door_2_Sprite.play("default")
		Door_2_Broken = true
		Broken.emit()

var body_in_ame_area = false
var body_in_singulo_area = false
var body_in_solar_area = false
var body_in_door_1_area = false
var body_in_door_2_area = false

# body entered

func _on_ame_body_entered(body: Node2D) -> void:
	body_in_ame_area = true
	if AME_Broken == true:
		Menu_Open.emit()
		$"../Menus".visible = true
		$"../Menus".set_frame(3)

func _on_singulo_body_entered(body: Node2D) -> void:
	body_in_singulo_area = true
	if Singulo_Broken == true:
		Menu_Open.emit()
		$"../Menus".visible = true
		$"../Menus".set_frame(2)

func _on_solar_body_entered(body: Node2D) -> void:
	body_in_solar_area = true
	if Solar_Broken == true:
		Menu_Open.emit()
		$"../Menus".visible = true
		$"../Menus".set_frame(1)

func _on_door_1_body_entered(body: Node2D) -> void:
	body_in_door_1_area = true
	if Door_1_Broken == true:
		Menu_Open.emit()
		$"../Menus".visible = true
		$"../Menus".set_frame(4)

func _on_door_2_body_entered(body: Node2D) -> void:
	body_in_door_2_area = true
	if Door_2_Broken == true:
		Menu_Open.emit()
		$"../Menus".visible = true
		$"../Menus".set_frame(4)

# body exited

func _on_ame_body_exited(body: Node2D) -> void:
	body_in_ame_area = false

func _on_singulo_body_exited(body: Node2D) -> void:
	body_in_singulo_area = false

func _on_solar_body_exited(body: Node2D) -> void:
	body_in_solar_area = false

func _on_door_1_body_exited(body: Node2D) -> void:
	body_in_door_1_area = false

func _on_door_2_body_exited(body: Node2D) -> void:
	body_in_door_2_area = false

# process

func _process(delta: float) -> void:
	if body_in_ame_area and Input.is_action_just_pressed("Interact") and AME_Broken == true:
		$AME/AME_Sprite.set_frame(0)
		Menu_Closed.emit()
		$"../Menus".visible = false
		AME_Broken = false
		Fixed.emit()
	if body_in_singulo_area and Input.is_action_just_pressed("Interact") and Singulo_Broken == true:
		$Singulo/Singulo_Sprite.set_frame(0)
		Menu_Closed.emit()
		$"../Menus".visible = false
		Singulo_Broken = false
		Fixed.emit()
	if body_in_solar_area and Input.is_action_just_pressed("Interact") and Solar_Broken == true:
		$Solar/Solar_Sprite.set_frame(0)
		Menu_Closed.emit()
		$"../Menus".visible = false
		Solar_Broken = false
		Fixed.emit()
	if body_in_door_1_area and Input.is_action_just_pressed("Interact") and Door_1_Broken == true:
		$Doors/Door_1/Door_1_Sprite.play_backwards("default")
		Menu_Closed.emit()
		$"../Menus".visible = false
		Door_1_Broken = false
		Fixed.emit()
	if body_in_door_2_area and Input.is_action_just_pressed("Interact") and Door_2_Broken == true:
		$Doors/Door_2/Door_2_Sprite.play_backwards("default")
		Menu_Closed.emit()
		$"../Menus".visible = false
		Door_2_Broken = false
		Fixed.emit()

#func _on_ame_body_entered(body: Node2D) -> void:
	#print("entered")
	#if Input.is_action_just_pressed("Interact"):
		#print("done")
		#$AME/AME_Sprite.set_frame(0)
