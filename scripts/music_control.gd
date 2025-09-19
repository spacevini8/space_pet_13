extends HSlider

@export var Audio_Bus_Name: String

var Audio_Bus_Id

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio_Bus_Id = AudioServer.get_bus_index(Audio_Bus_Name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(Audio_Bus_Id, db)
