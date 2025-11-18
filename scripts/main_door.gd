extends Node3D

@onready var folha_porta: Node3D = $FolhaPorta
@onready var folha_porta_2: Node3D = $FolhaPorta2
@onready var area_3d: Area3D = $Area3D

func _ready() -> void:
	area_3d.body_entered.connect(open)
	area_3d.body_exited.connect(close)
	
func open(body) -> void:
	if body is CharacterBody3D:
		var tween = create_tween()
		var second_tween = create_tween()
		tween.tween_property(folha_porta, "rotation:y", deg_to_rad(0), 1)
		second_tween.tween_property(folha_porta_2, "rotation:y", deg_to_rad(0), 1)

func close(_body) -> void:
	var tween = create_tween()
	var second_tween = create_tween()
	tween.tween_property(folha_porta, "rotation:y", deg_to_rad(-90), 1)
	second_tween.tween_property(folha_porta_2, "rotation:y", deg_to_rad(90), 1)
