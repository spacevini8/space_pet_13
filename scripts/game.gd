extends Node2D

signal Game_Over
signal Menu_Open
signal Menu_Closed

@onready var stats: Label = $Text/Stats
@onready var menus: AnimatedSprite2D = $Menus
@onready var options: Panel = $Menus/Options

var Score = 10
var Hunger = 10
var Income = 50
var Round = 0

var Scream_Finished_var = false

var Score_Penaly = 50

var Game_Over_var = false
var Pause = false

#var Text_Update = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)
	
	$Music.play()
	
	if OS.has_feature("web"):
		$Menus/Options/Quit.visible = false

func _on_player_scream_finished() -> void:
	Scream_Finished_var = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	
	# Escape
	
	if Input.is_action_just_pressed("Escape") and Pause == false:
		Menu_Open.emit()
		$Menus.set_frame(0)
		$Menus.visible = true
		$Menus/Options.visible = true
		Pause = true
	elif Input.is_action_just_pressed("Escape") and Pause == true:
		Menu_Closed.emit()
		$Menus.visible = false
		$Menus/Options.visible = false
		Pause = false
	
	# Game Over Hunger
	
	if Hunger >= 150:
		Game_Over.emit()
		$Menus.set_frame(5)
		$Menus.visible = true
		Game_Over_var = true
		
		if Input.is_action_just_pressed("Interact") and Game_Over_var == true and Scream_Finished_var == true:
			get_tree().reload_current_scene()
	
	# Game Over Power
	
	if Score < 0:
		Game_Over.emit()
		$Menus.set_frame(6)
		$Menus.visible = true
		Game_Over_var = true
	
		if Input.is_action_just_pressed("Interact") and Game_Over_var == true and Scream_Finished_var == true:
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
		Hunger -= 30.0 + (Round - 2)
		$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)
	else:
		Hunger = 0
		$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)
		
	if Hunger < 0:
		Hunger = 0

func _on_player_moved() -> void:
	Hunger += 2
	$Text/Stats.text = "Score: "+ str(Score) + "\nHunger: " + str(Hunger) + "\nIncome: " + str(Income) + "\nRound: " + str(Round)


func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_sfx_toggled(toggled_on: bool) -> void:
	var SFX_on = !toggled_on
	AudioServer.set_bus_mute(AudioServer.get_bus_index("SFX"), SFX_on)
