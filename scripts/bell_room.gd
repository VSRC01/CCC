extends Node3D

var bell_count : int = 0
@export var door : Node3D


@onready var sino: RigidBody3D = $Sino
@onready var sino_2: RigidBody3D = $Sino2


func _physics_process(delta: float) -> void:
	if bell_count == 4:
		sino.rotation.x += deg_to_rad(6)
		sino_2.rotation.x += deg_to_rad(6)
		if door.is_open == false:
			door.is_open = true
			door.open()
