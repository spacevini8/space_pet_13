extends Node

@onready var ame_sprite: AnimatedSprite2D = $AME/AME_Sprite
@onready var singulo_sprite: AnimatedSprite2D = $Singulo/Singulo_Sprite
@onready var solar_sprite: AnimatedSprite2D = $Solar/Solar_Sprite

var AME_Broken = false
var Singulo_Broken = false
var Solar_Broken = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_new_round() -> void:
	
	if randi_range(1,2) == 2:
		$AME/AME_Sprite.set_frame(1)
		AME_Broken = true
		
	if randi_range(1,2) == 2:
		$Singulo/Singulo_Sprite.set_frame(1)
		Singulo_Broken = true
		
	if randi_range(1,2) == 2:
		$Solar/Solar_Sprite.set_frame(1)
		Solar_Broken = true

var body_in_ame_area = false
var body_in_singulo_area = false
var body_in_solar_area = false

# body entered

func _on_ame_body_entered(body: Node2D) -> void:
	body_in_ame_area = true

func _on_singulo_body_entered(body: Node2D) -> void:
	body_in_singulo_area = true

func _on_solar_body_entered(body: Node2D) -> void:
	body_in_solar_area = true

# body exited

func _on_ame_body_exited(body: Node2D) -> void:
	body_in_ame_area = false

func _on_singulo_body_exited(body: Node2D) -> void:
	body_in_singulo_area = false

func _on_solar_body_exited(body: Node2D) -> void:
	body_in_solar_area = false

# process

func _process(delta: float) -> void:
	if body_in_ame_area and Input.is_action_just_pressed("Interact") and AME_Broken == true:
		$AME/AME_Sprite.set_frame(0)
		AME_Broken = false
	if body_in_singulo_area and Input.is_action_just_pressed("Interact") and Singulo_Broken == true:
		$Singulo/Singulo_Sprite.set_frame(0)
		Singulo_Broken = false
	if body_in_solar_area and Input.is_action_just_pressed("Interact") and Solar_Broken == true:
		$Solar/Solar_Sprite.set_frame(0)
		Solar_Broken = false

#func _on_ame_body_entered(body: Node2D) -> void:
	#print("entered")
	#if Input.is_action_just_pressed("Interact"):
		#print("done")
		#$AME/AME_Sprite.set_frame(0)
