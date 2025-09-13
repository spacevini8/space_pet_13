extends Node2D

signal Game_Over

@onready var stats: Label = $Text/Stats
@onready var menus: AnimatedSprite2D = $Menus

var Score = 10
var Hunger = 10.0
var Income = 50
var Round = 0

var Score_Penaly = 50

var Game_Over_var = false

#var Text_Update = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Hunger >= 150:
		Game_Over.emit()
		$Menus.set_frame(5)
		$Menus.visible = true
		Game_Over_var = true
		
		if Input.is_action_just_pressed("Interact") and Game_Over_var == true:
			get_tree().reload_current_scene()
	
	if Score < 0:
		Game_Over.emit()
		$Menus.set_frame(6)
		$Menus.visible = true
		Game_Over_var = true
	
		if Input.is_action_just_pressed("Interact") and Game_Over_var == true:
			get_tree().reload_current_scene()

func _on_machines_broken() -> void:
	Income -= Score_Penaly
	$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)

func _on_machines_fixed() -> void:
	Income += Score_Penaly
	Score += 20
	$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)

func _on_player_new_round() -> void:
	Round += 1
	Score += Income
	Hunger += 10 + Round
	$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)

func _on_machines_eat() -> void:
	if Hunger >= 30.0:
		Hunger -= 30.0 + Round
		$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)
	else:
		Hunger = 0
		$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)
		
	if Hunger < 0:
		Hunger = 0

func _on_player_moved() -> void:
	Hunger += 1.5
	$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)
