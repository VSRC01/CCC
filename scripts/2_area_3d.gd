extends Area3D

var parent

func _ready() -> void:
	parent = get_parent()
	connect("body_entered", fix_pannel)
	
func fix_pannel(body) -> void:
	match name:
		"2Area3D":
			if body is RigidBody3D:
				if body.name == "2":
					var player = body.find_parent("Player")
					if player:
						player.drop_pannel()
					body.reparent(self)
					body.freeze = true
					var tween = create_tween()
					tween.set_parallel()
					tween.tween_property(body, "position", Vector3.ZERO, .5)
					tween.tween_property(body, "rotation", Vector3.ZERO, .5)
					await  tween.finished
					parent.wall_pannels_amount += 1
					parent.puzzle_check()
					return
					
		"3Area3D":
			if body is RigidBody3D:
				if body.name == "3":
					var player = body.find_parent("Player")
					if player:
						player.drop_pannel()
					body.reparent(self)
					body.freeze = true
					var tween = create_tween()
					tween.set_parallel()
					tween.tween_property(body, "position", Vector3.ZERO, .5)
					tween.tween_property(body, "rotation", Vector3.ZERO, .5)
					await  tween.finished
					parent.wall_pannels_amount += 1
					parent.puzzle_check()
					return
		"4Area3D":
			if body is RigidBody3D:
				if body.name == "4":
					var player = body.find_parent("Player")
					if player:
						player.drop_pannel()
					body.reparent(self)
					body.freeze = true
					var tween = create_tween()
					tween.set_parallel()
					tween.tween_property(body, "position", Vector3.ZERO, .5)
					tween.tween_property(body, "rotation", Vector3.ZERO, .5)
					await  tween.finished
					parent.wall_pannels_amount += 1
					parent.puzzle_check()
					return
		"5Area3D":
			if body is RigidBody3D:
				if body.name == "5":
					var player = body.find_parent("Player")
					if player:
						player.drop_pannel()
					body.reparent(self)
					body.freeze = true
					var tween = create_tween()
					tween.set_parallel()
					tween.tween_property(body, "position", Vector3.ZERO, .5)
					tween.tween_property(body, "rotation", Vector3.ZERO, .5)
					await  tween.finished
					parent.wall_pannels_amount += 1
					parent.puzzle_check()
					return
		"6Area3D":
			if body is RigidBody3D:
				if body.name == "6":
					var player = body.find_parent("Player")
					if player:
						player.drop_pannel()
					body.reparent(self)
					body.freeze = true
					var tween = create_tween()
					tween.set_parallel()
					tween.tween_property(body, "position", Vector3.ZERO, .5)
					tween.tween_property(body, "rotation", Vector3.ZERO, .5)
					await  tween.finished
					parent.wall_pannels_amount += 1
					parent.puzzle_check()
					return
		"7Area3D":
			if body is RigidBody3D:
				if body.name == "7":
					var player = body.find_parent("Player")
					if player:
						player.drop_pannel()
					body.reparent(self)
					body.freeze = true
					var tween = create_tween()
					tween.set_parallel()
					tween.tween_property(body, "position", Vector3.ZERO, .5)
					tween.tween_property(body, "rotation", Vector3.ZERO, .5)
					await  tween.finished
					parent.wall_pannels_amount += 1
					parent.puzzle_check()
					return
