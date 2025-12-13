extends Node3D

func open():
	var tween = create_tween()
	tween.tween_property(self, "rotation:y", deg_to_rad(90), 1)
