extends Area3D

func _ready() -> void:
	connect("body_entered", fix_pannel)
	
func fix_pannel(body) -> void:
	if body is RigidBody3D:
		if body.name == "2":
			var player = body.find_parent("Player")
			if player:
				player.drop_pannel()
			body.reparent(self)
			body.freeze = true
			var tween = create_tween()
			tween.tween_property(body, "position", Vector3.ZERO, .5)
			
	
