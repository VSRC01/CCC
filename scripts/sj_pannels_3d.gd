extends Node3D

@onready var door_n_2: Node3D = $DoorN2

var wall_pannels_amount : int = 0
var main_level

func _ready() -> void:
	main_level = get_parent()

func puzzle_check() -> void:
	if wall_pannels_amount == 12:
		door_n_2.open()
		main_level.player.cell_phone.notify()
		
	
