extends Node3D

@onready var folha_porta: Node3D = $FolhaPorta
@onready var folha_porta_2: Node3D = $FolhaPorta2

var is_open : bool = false

func open() -> void:
	var tween = create_tween()
	var door_tween = create_tween()
	var second_tween = create_tween()
	door_tween.tween_property(folha_porta, "rotation:y", deg_to_rad(0), 1)
	second_tween.tween_property(folha_porta_2, "rotation:y", deg_to_rad(0), 1)
	is_open = true
