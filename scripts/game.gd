extends Node2D

@onready var stats: Label = $Text/Stats

var Score = 10
var Hunger = 10.0
var Income = 50
var Round = 0

var Score_Penaly = 50

#var Text_Update = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
	if Hunger > 30:
		Hunger -= 30 + Round
		$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)
	else:
		Hunger = 0
		$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)

func _on_player_moved() -> void:
	Hunger += 1.5
	$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)
