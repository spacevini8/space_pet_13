extends Node

@onready var ame_sprite: AnimatedSprite2D = $AME/AME_Sprite
@onready var singulo_sprite: AnimatedSprite2D = $Singulo/Singulo_Sprite
@onready var solar_sprite: AnimatedSprite2D = $Solar/Solar_Sprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_round() -> void:
	
	if randi_range(1,2) == 2:
		$AME/AME_Sprite.set_frame_and_progress(1, 1)
		
	if randi_range(1,2) == 2:
		$Singulo/Singulo_Sprite.set_frame_and_progress(1, 1)
		
	if randi_range(1,2) == 2:
		$Solar/Solar_Sprite.set_frame_and_progress(1, 1)
