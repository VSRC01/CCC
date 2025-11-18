extends Label3D

@onready var Area := $Area3D

var mouse_hovering = false

func _on_area_3d_mouse_entered() -> void:
	mouse_hovering = true

func _on_area_3d_mouse_exited() -> void:
	mouse_hovering = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left") and mouse_hovering:
		get_parent().to_journal()
