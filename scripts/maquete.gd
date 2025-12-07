extends Node3D

@onready var door = $DoorN3

var fixed_model_count : int = 0
var main_level

func _ready() -> void:
	main_level = get_parent()

func puzzle_check() -> void:
	if fixed_model_count == 6:
		door.open()
		main_level.player.cell_phone.notify()
